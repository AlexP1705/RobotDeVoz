#!/bin/bash

# Define la URL del portal de noticias
url="https://elpais.com/"

# Comprueba si wget o curl están instalados
if command -v wget &> /dev/null; then
    downloader="wget -q -O - \"$url\" > elpais_source.html"
elif command -v curl &> /dev/null; then
    downloader="curl -s \"$url\" > elpais_source.html"
else
    echo "Ni wget ni curl están instalados. Intentando instalar wget..."
    apt-get update && apt-get install wget -y
    if command -v wget &> /dev/null; then
        echo "wget instalado con éxito."
        downloader="wget -q -O - \"$url\" > elpais_source.html"
    else
        echo "No se pudo instalar wget. Abortando..."
        exit 1
    fi
fi

# Ejecuta el comando de descarga seleccionado
eval $downloader

# Comprueba si el archivo se descargó correctamente
if [ ! -s elpais_source.html ]; then
    echo "Error al descargar el código fuente de la página. Verifica la URL y tu conexión a internet."
    exit 1
else
    echo "Descarga completada. Archivo HTML guardado como elpais_source.html"
fi
