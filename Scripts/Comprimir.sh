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

#Creamos un archivo vacío, donde almacenaremos la lista de nombres válidos de las imágenes.
touch nombresvalidos.txt

#Iteramos dentro de los archivos contenidos en la carpeta imagenes_tp_procesadas.
for f in ./imagenes_tp_procesadas/*
do                       
  NOMBREVALIDO=$(basename "$f")  #Nos quedamos con el nombre de los archivos.
   
   echo "$NOMBREVALIDO" >> "$nombresvalidos.txt" #Se agregan dichos nombres al nuevo archivo creado.
done 

#Creamos un archivo vacío, el cual contendrá los nombres válidos que finalicen en A.
touch nombresterminadosenA.txt 

#Iteramos dentro del archivo de nombres válidos previamente creado.
for l in $(cat nombresvalidos.txt)
  if [[ "$NOMBREAFINAL" == A* ]]        #Chequeamos que dichos nombres terminen con la letra A.
  then
    echo "$NOMBREAFINAL" >> "$nombresterminadosenA.txt" #En caso de que así sea, se agregan los mismos al archivo.
  else continue #Caso contrario, continúa iterando.
  fi 
  
done 

echo "Los nombres terminados en A fueron guardados en listadenombresconA.txt"

#Empaquetamos y comprimimos los archivos con los nombres e imágenes.
echo "Comprimiendo archivos de texto e imagenes..."
zip -r nombreseimagenes_tp.zip imagenes_tp listadenombres.txt nombresvalidos.txt nombresterminadosenA.txt

echo "Archivos comprimidos de forma exitosa"

exit 0