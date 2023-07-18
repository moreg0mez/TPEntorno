#!/bin/bash

#Vamos a la carpeta anterior donde esta el menu, archivos y carpetas
cd ..


#Vemos si ya se corrieron todos los scpripts
if [ -e LAST.zip ]; then
    read -p "¿ Desea borrar el Zip final y comenzar de nuevo ? (1 = SI, 0 = NO): " RESP
    if [ "$RESP" == "0" ]; then
       exit 1
    else
       rm LAST.zip
    fi
fi

#Vemos si ya existe o no el .zip, si ya fue creado, mandamos al paso 2)

if [ -e imagenes_tp.zip ]; then
   echo "ERROR: Ya existe un archivo con imagenes continue con la opcion 2)"
   exit 1
fi

#Verificamos que el argumento sea 1 solo y que sea un numero

if ([ $# -eq 1 ] && [[ $1 =~ ^[0-9]+$ ]]); then
  echo "Input correcto, aguarde un momento"
  NUMIMG=$1

else
  echo  "Input no valido, ingrese un numero como Argumento"
  exit 1

fi

mkdir -p imagenes_tp
cd imagenes_tp
echo "Descargando imagenes y lista de nombres..."
curl -o lista_tp "https://raw.githubusercontent.com/adalessandro/EdP-2023-TP-Final/main/dict.csv"

for (( i=1; i<=$NUMIMG; i++ )); do #iteramos usando como limite el argumento que puso el usuario

   curl -o imagen$i "https://thispersondoesnotexist.com/"
   echo Imagen $i descargada y renombrada
   NOMBRE=$(shuf -n 1 lista_tp) # shuf toma una linea o nombre al azar y hace sustitucion de variable a NOMBRE
   mv imagen$i "./$NOMBRE" # se renombra la actual iteracion por $NOMBRE (el nombre al azar)
   sleep 2

done
rm lista_tp # se borra la lista y se vuelve al dir anterior
cd ..
echo "Las imagenes fueron descargadas y renombradas al directorio imagenes_tp"

#Empaqueto y comprimo con zip
echo "Comprimiendo imagenes..."
zip -r imagenes_tp.zip imagenes_tp

#Genero el archivo checksum
echo "Generando checksum..."
md5sum imagenes_tp.zip > chk_sum.txt #redirecciono el checksum al archivo .txt

rm -r imagenes_tp   #borramos esta carpeta sino daba un error en el menu
echo "TODO LISTO!"
exit 0

