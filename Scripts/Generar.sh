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
echo "Descargando imagenes y lista de nombres..."
curl -o lista_tp "https://raw.githubusercontent.com/adalessandro/EdP-2023-TP-Final/main/dict.csv"

for (( i=1; i<=$NUMIMG; i++ )); do

   curl -o imagen$i "https://thispersondoesnotexist.com/"
   echo Imagen $i descargada y renombrada
   NOMBRE=$(shuf -n 1 lista_tp) # shuf toma una linea al azar y hace sustitucion de varible a NOMBRE
   mv imagen$i "./$NOMBRE" # el ./ indica que se guarde en el directorio actual
   sleep 2

done
rm lista_tp # se borra la lista y se vuelve al dir anterior
cd ..
echo "Las imagenes fueron descargadas y renombradas al directorio imagenes_tp"

#Empaqueto y comprimo con zip
echo "Comprimiendo imagenes..."
zip -r imagenes_tp.zip imagenes_tp

#Genero el archivo checksum
echo "generando checksum..."
touch chksum.txt
md5sum imagenes_tp.zip > chk_sum.txt #redirecciono el chechum al archivo .txt

echo "TODO LISTO!"

exit 0
































