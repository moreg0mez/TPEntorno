#!/bin/bash

#voy a la carpeta donde esta imagenes_tp
cd ..

[ -e imagenes_tp_procesadas ] && echo "ERROR: La carpeta imagenes_tp_procesadas ya existe, continue con la opcion 4)" && exit 1

#Verifico que exista, si no retorno un mensaje de error.
if [ -e imagenes_tp ]; then
   echo "La carpeta de imagenes existe... procesando imagenes..."
else
   echo -e "ERROR: La carpeta de imagenes NO EXISTE. Antes debe ejecutar Generar.shn\n"
   exit 1
fi

#Aclaro que no hace falte incluir argumentos, el script solo necesita ser
#ejecutado para procesar las imagenes
[ "$#" -ne 0 ] && echo "Ejecute el script sin argumentos" && exit 1

#Me aseguro que esta el imagemagick
#sudo apt-get install imagemagick
#Esto aca no iba hay que hacerlo en el dockerfile

#Creo la nueva carpeta en donde se guardaran las imagenes procesadas
mkdir imagenes_tp_procesadas

#Se inicia un loop for para iterar sobre las imagenes de imagenes_tp
for i in ./imagenes_tp/* # El wildcard toma todos los nombres
do                       # de archivo, luego basename deja SOLO el nombre del archivo
   NOMBRE=$(basename "$i")
                                            # =~ compara el Nombre con la expresion regular para verificar
   if [[ "$NOMBRE" =~ ^[A-Z][a-z]+ ]]; then #que empiece con mayuscula y siga con minusculas
      convert "./imagenes_tp/$NOMBRE" -gravity center -resize 512x512+0+0 -extent 512x512 "./imagenes_tp_procesadas/$NOMBRE"
      echo "Imagen procesada, aguarde..."
   else continue
   fi

done

echo "Todas las imagenes fueron procesadas y guardadas en imagenes_tp_procesadas"

exit 0







