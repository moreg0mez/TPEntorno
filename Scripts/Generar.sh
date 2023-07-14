#!/bin/bash


if ([ $# -eq 1 ] && [[ $1 =~ ^[0-9]+$ ]]); then
  echo "Input correcto, aguarde un momento"
  NUMIMG=$1

else
  echo  "Input no valido, ingrese un numero"
  exit 1

fi


mkdir -p imagenes_tp
cd imagenes_tp
echo "Descargando imagenes... aguarde"

for (( i=1; i<=$NUMIMG; i++ )); do

   curl -o imagen$i "https://thispersondoesnotexist.com/"
   echo Imagen $i descargada...
   sleep 2

done
echo "Las imagenes fueron descargas a imaganes_tp"




















