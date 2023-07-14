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
cd ..
echo "Las imagenes fueron descargas a imaganes_tp"

echo "Descargando lista de nombres..."
curl -o lista_tp "https://raw.githubusercontent.com/adalessandro/EdP-2023-TP-Final/main/dict.csv"
echo "Lista de nombres descargada como lista_tp"


























