require 'net/http'
require 'json'
require_relative 'ticker'

class Extractor
  attr_reader :tickers

  def initialize(timestamp=Time.now.to_i()*1000)
    @tickers = []
    #al inicializar buscamos cada mercado y creamos un nuevo objeto Ticker (dentro de mercados_parsed) para cada mercado, y actualizamos su precio
    response = buscar_mercados
    mercados_parsed(response,timestamp)
  end

  private

  def buscar_mercados
    url = "https://www.buda.com/api/v2/markets"
    uri = URI(url)
    respuestas = Net::HTTP.get(uri)
    JSON.parse(respuestas)
  end

  def mercados_parsed(response,timestamp)
    mercados = response["markets"]

    mercados.each do |market|
      ticker = Ticker.new(market["id"])
      ticker.actualizar_precio(timestamp)
      @tickers << ticker
    end
  end

  public

  def a_html

    contenido_html = "<html>\n<head>\n<title>Tickers</title>\n</head>\n<body>\n"
    contenido_html += "<table>\n<thead>\n<tr><th>Codigo</th><th>Precio</th><th>Cantidad</th><th>Tipo</th><th>Timestamp</th></tr>\n</thead>\n<tbody>\n"

    @tickers.each do |ticker|
      contenido_html += "<tr><td>#{ticker.codigo}</td><td>#{ticker.precio}</td><td>#{ticker.cantidad}</td><td>#{ticker.tipo}</td><td>#{ticker.timestamp}</td></tr>\n"
    end

    contenido_html += "</tbody>\n</table>\n</body>\n</html>"

    File.write("tickers.html", contenido_html)
  end
end
