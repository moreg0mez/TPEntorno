#!/bin/bash

#Navegamos hasta la carpeta donde está el contenido a usar.
cd ..

#Borramos el contenido que no se utilizará.
rm chk_sum.txt
rm imagenes_tp.zip

#Creamos un archivo vacío, al cual luego le agregaremos la lista de nombres de todas las imágenes.
touch listadenombres.txt

#Iteramos dentro del directorio que contiene las imágenes generadas con generar.sh
for f in ./imagenes_tp/*
do                       
   NOMBRE=$(basename "$f")  #Nos quedamos con el nombre de los archivos.

   echo "$NOMBRE" >> "$listadenombres.txt" #Se agregan dichos nombres al nuevo archivo creado.
done 

echo "Los nombres de todas las imagenes fueron guardados en listadenombres.txt"

#Creamos un archivo vacío, donde almacenaremos la lista de nombres VÁLIDOS de las imágenes.
touch listadenombresconA.txt

#Iteramos dentro de los archivos contenidos en la carpeta imagenes_tp_procesadas.
for f in ./imagenes_tp_procesadas/*
do                       
  NOMBRE=$(basename "$f")  #Nos quedamos con el nombre de los archivos.

  if [[ "$NOMBRE" = A* ]]        #Chequeamos que dichos nombres comiencen con la letra A.
  then
    echo "$NOMBRE" >> "$listadenombresconA.txt" #En caso de que así sea, se agregan los mismos al nuevo archivo creado.
  else continue #Caso contrario, continúa iterando.
  fi 
  
done 

echo "Los nombres con A fueron guardados en listadenombresconA.txt"
