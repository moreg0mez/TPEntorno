#!/bin/bash

#Vamos a la carpeta anterior donde esta el menu, archivos y carpetas
cd ..


#Vemos si ya se corrieron todos los scpripts
if ([ -e "./imagenes_comprimidas_tp/LAST.zip" ] || [ -e "./LAST.zip" ]); then
    read -p "¿ Desea borrar el Zip final y comenzar de nuevo ? (1 = SI, 0 = NO): " RESP
    if [ "$RESP" == "0" ]; then
       exit 1
    else
       rm  "./imagenes_comprimidas_tp/LAST.zip"
       rm "./LAST.zip"
    fi
fi

#Vemos si ya existe o no el .zip, si ya fue creado, mandamos al paso 2)

if [ -e imagenes_tp.zip ]; then
   echo "ERROR: Ya existe un archivo con imagenes continue con la opcion 2) o 3)"
   echo -e "Lista de opciones:" 
   echo -e "1) Generar.sh" 
   echo -e "2) Descomprimir.sh"
   echo -e "3) Procesar.sh"
   echo -e "4) Comprimir.sh"
   echo -e "5) Quit" 
   exit 1
fi

#Verificamos que el argumento sea 1 solo y que sea un numero

if ([ $# -eq 1 ] && [[ $1 =~ ^[0-9]+$ ]]); then
  echo -e "Input correcto, aguarde un momento...\n"
  NUMIMG=$1

else
  echo  "Input no valido, ingrese un numero como Argumento"
  exit 1

fi

mkdir -p imagenes_tp
cd imagenes_tp
echo -e "Descargando imagenes y lista de nombres...\n"
curl -o lista_tp "https://raw.githubusercontent.com/adalessandro/EdP-2023-TP-Final/main/dict.csv"

for (( i=1; i<=$NUMIMG; i++ )); do #iteramos usando como limite el argumento que puso el usuario

   curl -o imagen$i "https://thispersondoesnotexist.com/"
   echo -e "Imagen $i descargada y renombrada\n"
   NOMBRE=$(shuf -n 1 lista_tp) # shuf toma una linea o nombre al azar y hace sustitucion de variable a NOMBRE
   mv imagen$i "./$NOMBRE" # se renombra la actual iteracion por $NOMBRE (el nombre al azar)
   sleep 2

done
rm lista_tp # se borra la lista y se vuelve al dir anterior
cd ..
echo -e "Las imagenes fueron descargadas y renombradas al directorio imagenes_tp\n"

#Empaqueto y comprimo con zip
echo -e "Comprimiendo imagenes...\n"
zip -r imagenes_tp.zip imagenes_tp

#Genero el archivo checksum
echo -e "Generando checksum...\n"
md5sum imagenes_tp.zip > chk_sum.txt #redirecciono el checksum al archivo .txt

rm -r imagenes_tp   #borramos esta carpeta sino daba un error en el menu
echo -e "TODO LISTO\n"

#Imprimimos el menu nuevamente para facilitar la eleccion de opciones
echo -e "Lista de opciones:" 
echo -e "1) Generar.sh" 
echo -e "2) Descomprimir.sh"
echo -e "3) Procesar.sh"
echo -e "4) Comprimir.sh"
echo -e "5) Quit"

exit 0

