# Documentación del programa
Este proyecto corresponde a mi respuesta de la tarea técnica para grupoMOK.

Esta es mi primera experiencia personal con Ruby.

Este programa utiliza las clases `Extractor` y `Ticker` para extraer y procesar información sobre los mercados ofrecidos por BUDA.com.

## Estructura de archivos

El programa está compuesto por los siguientes archivos:

1. `main.rb`: Este archivo es el punto de entrada del programa y crea un objeto `Extractor` desde `extractor.rb`.
2. `extractor.rb`: Este archivo contiene la definición de la clase `Extractor`, que maneja la extracción y procesamiento de datos.
3. `tickers.rb`: Este archivo contiene la definición de la clase `Ticker`, que representa un ticker de mercado con atributos como `codigo`, `timestamp`, `precio`, `cantidad` y `tipo` guardando la transacción de mayor valor en las últimas 24 horas para tal mercado.

## Uso del programa

1. Ejecutar el script `main.rb`
2. El programa creará un objeto `Extractor`, que buscará información de mercados y creará una serie de objetos `Ticker` con los datos correspondientes.
3. El método `a_html` del objeto `Extractor` generará un archivo HTML llamado `tickers.html` que mostrará una tabla con los datos de los tickers extraídos.

## Clase Extractor

La clase `Extractor` tiene los siguientes métodos:

- `initialize`: Constructor que inicializa el objeto `Extractor` y realiza la extracción de datos de los mercados durante las 24H previas al timestamp indicado. Toma como argumento opcional un timestamp,pero por defecto usa el tiempo actual al momento de inicialización.
- `a_html`: Método público que genera un archivo HTML con una tabla que muestra los datos de los tickers extraídos.

## Clase Ticker

La clase `Ticker` tiene los siguientes atributos:

- `codigo`: Código del mercado i.e "BTC-CLP","ETH-CLP",etc...
- `timestamp`: Hora, en tiempo Unix en milisegundos, de la transacción de valor más alto.
- `precio`: Precio por unidad para la transacciòn de valor más alto en las 24H previas
- `cantidad`: Cantidad del la transacción de valor más alto en las 24H previas.
- `tipo`: Tipo de la transacción. i.e. "buy", "sell", nil.

En el caso de que no hayan habido transacciones en el período indicado, se espera que el "tipo" sea nil, y "timestamp","precio" y "cantidad" sean 0, los cuales corresponden al momento de inicialización.

Además, la clase `Ticker` tiene un método:

- `initialize`: Constructor que inicializa el objeto `Ticker`, este píde el parámetro "codigo", el cual corresponde al ticker a analizar. Al momento de inicializar el resto de los valores inician en 0 y el tipo en nil.
- `actualizar_precio`: Método que actualiza el precio del ticker. Por defecto se ejecuta con el parametro opcional tiempo_actual para el momento de ejecución de la función, pero puede usarse con cualquier timestamp unix en milisegundos para considerar la ventana de 24H anterior.

## Notas adicionales

El archivo generado sigue un formato mínimalista asumiendo que es con fines de consumo de información y no para uso de cliente, de todas maneras la solución al problema está implementada de tal forma que esta pueda ser usada para otros usos apropiados con suma facilidad.