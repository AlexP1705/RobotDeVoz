#!/bin/bash

# Función para verificar si un comando está disponible
comando_existe() {
  command -v "$1" &> /dev/null
}

# Función para leer noticias y sintetizar a voz
leer_noticias() {
  sintetizador=$1
  archivo_noticias="processed_headlines.txt" 

  # Verificar si el archivo de noticias existe
  if [ ! -f "$archivo_noticias" ]; then
    echo "El archivo de noticias $archivo_noticias no existe."
    exit 1
  fi

  while IFS= read -r line; do
    titulo=$(echo "$line" | cut -d '-' -f 1)
    enlace=$(echo "$line" | cut -d '-' -f 2-)
    echo "Leyendo: $titulo"
    echo "Enlace: $enlace"
    if [ "$sintetizador" = "espeak" ]; then
        # Ajusta la velocidad con -s, el tono con -p, y selecciona una voz con -v
        espeak -s 50 -p 50 -v mb-es1 "$titulo" 2>/dev/null
    elif [ "$sintetizador" = "festival" ]; then
        # Esta opción indica a Festival que convierta el texto de entrada en habla (Text-To-Speech, TTS).
        echo "$titulo" | festival --tts
    fi
  done < "$archivo_noticias"
}

# Verificar si espeak o festival están instalados
if comando_existe espeak; then
  echo "Usando espeak para leer las noticias..."
  leer_noticias "espeak"
elif comando_existe festival; then
  echo "Usando festival para leer las noticias..."
  leer_noticias "festival"
else
  echo "Ninguno de los sintetizadores de texto a voz (espeak, festival) está instalado."
  echo "Intentando instalar espeak..."
  if comando_existe apt; then
     apt update &&  apt install -y espeak
    # Verifica si espeak se instaló correctamente
    if comando_existe espeak; then
      echo "Espeak instalado correctamente."
      leer_noticias "espeak"
    else
      echo "La instalación de espeak falló."
    fi
  elif comando_existe yum; then
     yum install -y espeak
    # Verifica si espeak se instaló correctamente
    if comando_existe espeak; then
      echo "Espeak instalado correctamente."
      leer_noticias "espeak"
    else
      echo "La instalación de espeak falló."
    fi
  else
    echo "No se pudo instalar espeak. Tu sistema no tiene 'apt' ni 'yum'. Por favor, instala espeak manualmente."
  fi
fi
