require_relative 'extractor'
require_relative 'ticker'

#creamos el objeto extractor, que busca la info apropiada y contiene un arreglo de Tickers, con la info buscada

extractor = Extractor.new()

#generamos la página en HTML que contiene los datos de extractor
extractor.a_html