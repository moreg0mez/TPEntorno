#!/bin/bash

#Navegamos hasta la carpeta donde está el contenido a usar.
cd ..

#Si el LAST.zip ya fue comprimido tiramos este ERROR
[ -e LAST.zip ] && echo "ERROR: El archivo LAST.zip ya existe: Elija opcion 1) para volver a comenzar" && exit 1

#Este script no necesita argumentos, en caso contrario retornamos un mensaje de error
[ "$#" -ne 0 ] && echo -e "ERROR: Ejecute el script sin argumentos\n" && exit 1

#Verificamos que existan las carpetas necesarias
! [ -e "imagenes_tp" ] && echo -e "ERROR: La carpeta imagenes_tp NO EXISTE, antes ejecute Generar.sh\n" && exit 1
! [ -e "imagenes_tp_procesadas" ] && echo -e "ERROR: La carpeta imagenes_tp_procesadas NO EXISTE, antes ejecute Generar.sh\n" && exit 1
echo -e "Las carpetas necesarias existen, aguarde\n"

#Borramos el contenido que no se utilizará.
rm chk_sum.txt
rm imagenes_tp.zip

#Iteramos dentro del directorio que contiene las imágenes generadas con generar.sh
for f in ./imagenes_tp/*
do
   NOMBRE_Y_EDAD=$(basename "$f")
   NOMBRE_SOLO=$(echo "$NOMBRE_Y_EDAD" | cut -d "," -f1)
   echo "$NOMBRE_SOLO" >> lista_nombres.txt #Se agregan dichos nombres al nuevo archivo creado.
done
echo "Los nombres de todas las imágenes fueron guardados en lista_nombres.txt"

#Iteramos dentro de los archivos contenidos en la carpeta imagenes_tp_procesadas (los cuales son nombres válidos)
for f in ./imagenes_tp_procesadas/*
do
   NOMBRE_Y_EDAD=$(basename "$f")
   NOMBRE_SOLO=$(echo "$NOMBRE_Y_EDAD" | cut -d "," -f1)
   echo "$NOMBRE_SOLO" >> nombres_validos.txt #Los mismos se agregan al nuevo archivo nombres_validos.
done
echo "Los nombres válidos fueron guardados en nombres_validos"


#Iteramos dentro de la carpeta imagenes_tp_procesadas.
for l in ./imagenes_tp_procesadas/*
do
   NOMBRE_Y_EDAD=$(basename "$l")
   NOMBRE_Y_APELLIDO=$(echo "$NOMBRE_Y_EDAD" | cut -d "," -f1)
   NOMBRE_SOLO=$( echo "$NOMBRE_Y_APELLIDO" | cut -d " " -f1)
   if [[ "$NOMBRE_SOLO" =~ a$ ]];      #Chequeamos si los nombres terminan en a.
      then
      echo "$NOMBRE_Y_APELLIDO" >> nombres_a.txt #En caso positivo, los guardamos en el nuevo archivo nombres_a.
   fi
done

echo "Los nombres terminados en a fueron guardados en nombres_a" 

#Empaquetamos y comprimimos los archivos con los nombres e imágenes.
echo "Comprimiendo archivos de texto e imagenes..."
zip -r LAST.zip imagenes_tp imagenes_tp_procesadas lista_nombres.txt nombres_validos.txt nombres_a.txt
echo "Archivos comprimidos de forma exitosa"

#Borramos el contenido que no usaremos.
rm -r imagenes_tp
rm -r imagenes_tp_procesadas
rm lista_nombres.txt
rm nombres_validos.txt
rm nombres_a.txt

exit 0
