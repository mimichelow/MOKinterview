require 'net/http'
require 'json'
class Ticker
  attr_reader :codigo, :timestamp, :precio, :cantidad, :tipo

  def initialize(code)
    @codigo = code
    @timestamp = 0
    @precio = 0
    @cantidad = 0
    @tipo = nil
  end

  def actualizar_precio(tiempo_actual=Time.now.to_i()*1000)
    #tiempo sobre el cual iteramos, usamos este formato para poder sincronizar las ventanas de 24H
    tiempo_pregunta=tiempo_actual
    tiempo_corte=tiempo_actual-60*60*24*1000

    #iteramos hasta que el last_timestamp de respuesta sea menor a la hora de corte
      loop do
        url = "https://www.buda.com/api/v2/markets/#{@codigo}/trades?timestamp=#{tiempo_pregunta}&limit=100"
        uri = URI(url)

        respuesta = Net::HTTP.get(uri)
        respuesta_parsed = JSON.parse(respuesta)

        trades = respuesta_parsed["trades"]["entries"]
        trades.each do |entry|
          timestamp = entry[0].to_i
          cantidad = entry[1].to_f
          precio = entry[2].to_f
          tipo = entry[3]
          #si una venta es mayor, actualizamos la venta guardada al menos que una trade sea anterior a la hora de corte
          if tiempo_corte >timestamp
            break
          end
          if precio*cantidad>@precio*@cantidad
            #no actualizar trades hechas en tiempos anteriores a 24 horas antes

            @precio = precio
            @cantidad = cantidad
            @timestamp = timestamp
            @tipo = tipo
          end
        end
          #actualizamos el tiempo de inicio de la siguiente iteración
          tiempo_pregunta=respuesta_parsed["trades"]["last_timestamp"].to_i
          #cortamos la iteración si la última hora es mayor a nuestra hora Corte
        break if tiempo_corte>tiempo_pregunta
      end
  end

  def to_s
    "<codigo = #{@codigo}, precio = #{@precio}, cantidad = #{@cantidad}, tipo = #{@tipo}, timestamp = #{@timestamp}>"
  end
end
