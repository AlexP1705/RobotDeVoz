# Busca patrones que podrían indicar titulares. 
# Este comando busca ejemplos de etiquetas <h1>, <h2>, y <a> que podrían contener titulares.
#-P: Esta opción le dice a grep que interprete el patrón de búsqueda como una expresión regular de Perl(expresiones regulares mas optimizadas). 
#Las expresiones regulares de Perl son más potentes y flexibles que las expresiones regulares básicas que grep utiliza por defecto.
grep -oP '(<h1[^>]*>.*?</h1>|<h2[^>]*>.*?</h2>|<a[^>]*class="[^"]*titulo[^"]*"[^>]*>.*?</a>)' elpais_source.html > headlines.txt

# Muestra los resultados
cat headlines.txt