#!/bin/bash

#voy a la carpeta donde esta imagenes_tp
cd ..

#Verifico que exista sino tiro error
if [ -e imagenes_tp ]; then
   echo "La carpeta de imagenes existe... procesando imagenes..."
else
   echo "ERROR: La carpeta de imagenes NO EXISTE. 1ro debe ejecutar Generar.sh"
fi

#Pongo que no hace falte incluir argumentos, el script solo necesita ser
#ejecutado y procesa las imaganes
[ "$#" -ne 0 ] && echo "Ejecute el script sin argumentos" && exit 1

#Me aseguro que esta el imagemagick
sudo apt-get install imagemagick

#Creo la nueva carpeta en donde se guardaran las imagenes procesadas
mkdir imagenes_tp_procesadas

#Se inicia un loop for para iterar sobre las imagenes de imagenes_tp
for i in ./imagenes_tp/* # El wildcard toma todos los nombres
do                       # de archivo, luego basename deja SOLO el nombre del archivo
   NOMBRE=$(basename "$i")
                                            # =~ compara el Nombre con la expresion regular para verificar
   if [[ "$NOMBRE" =~ ^[A-Z][a-z]+ ]]; then #que empiece com mayuscula y siga con minusculas
      convert "./imagenes_tp/$NOMBRE" -gravity center -resize 512x512+0+0 -extent 512x512 "./imagenes_tp_procesadas/$NOMBRE"
      echo "Imagen procesada, aguarde..."
   else continue
   fi

done

echo "Todas las imagenes fueron procesadas y guardadas en imagenes_tp_procesadas"

exit 0







