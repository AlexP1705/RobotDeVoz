#!/bin/bash
# Archivo con los titulares descargados
INPUT_FILE="headlines.txt"
OUTPUT_FILE="processed_headlines.txt"

# Limpiar o crear el archivo de salida
> "$OUTPUT_FILE"

# Procesar cada titular
while IFS= read -r line; do
    # Extraer el texto del titular
    headline_text=$(echo "$line" | grep -oP '(?<=>)[^<]+(?=<\/a>)')
    # Extraer el enlace del titular
    headline_link=$(echo "$line" | grep -oP '(?<=href=")[^"]+')

    # Escribir el resultado en el archivo de salida
    echo "$headline_text - $headline_link" >> "$OUTPUT_FILE"
done < "$INPUT_FILE"

echo "Procesamiento completado. Titulares guardados en $OUTPUT_FILE"