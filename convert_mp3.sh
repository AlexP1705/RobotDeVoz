#!/bin/bash

sintetizador="espeak" # o "festival", dependiendo de tu configuración
archivo_noticias="processed_headlines.txt"
archivo_final="todos_los_titulares.mp3"

# Verifica si el archivo de noticias existe
if [ ! -f "$archivo_noticias" ]; then
  echo "El archivo de noticias $archivo_noticias no existe."
  exit 1
fi

# Prepara el texto completo en una variable
texto_completo=""
while IFS= read -r line; do
    titulo=$(echo "$line" | cut -d '-' -f 1)
    texto_completo="${texto_completo}${titulo}\n"
done < "$archivo_noticias"

# Genera el audio del texto completo
if [ "$sintetizador" = "espeak" ]; then
    echo -e "$texto_completo" | espeak --stdout -s 150 -p 50 -v mb-es1 | ffmpeg -i - -ar 44100 -ac 2 -ab 192k -f mp3 -y "$archivo_final"
elif [ "$sintetizador" = "festival" ]; then
    # Para Festival, el proceso puede variar ya que depende de cómo se integre con ffmpeg
    echo "Festival no está directamente soportado en este ejemplo."
fi

echo "Todos los titulares han sido sintetizados en $archivo_final"