#!/bin/bash

chmod -R 777 ./imagenes_comprimidas_tp #Se otorgan permisos a la carpeta donde se almacenará el zip. 
cd Scripts 

echo "Lista de Scripts"
PS3="Por favor, elija una opcion: "
scripts=("Generar.sh" "Descomprimir.sh" "Procesar.sh" "Comprimir.sh" "Quit")

#Se evalúan caso por caso las distintas opciones ofrecidas dentro de la variable scripts.
select opt in "${scripts[@]}"
do
   case $opt in
        "Generar.sh")
             read -p "Ingrese el numero de fotos que desea generar: " NUM_FOTOS
             bash ./Generar.sh "$NUM_FOTOS"
             ;;

        "Descomprimir.sh")
             cd ..
             # Estas verificaciones podrían omitirse dado que el script ya las tiene, pero cumplen el objetivo de evitar pedir  input al usuario
             # en caso de que los archivos no existan. 
             ! [ -e imagenes_tp.zip ] && echo -e "ERROR: El archivo imagenes_tp.zip NO EXISTE, primero ejecute 1)\n" && cd Scripts && continue
             ! [ -e chk_sum.txt ] && echo -e "ERROR: El archivo chk_sum.txt NO EXISTE, primero ejecute 1)\n" && cd Scripts && continue
             cd Scripts
             read -p 'Ingrese el nombre del zip --> "imagenes_tp.zip": ' ARG1
             read -p 'Ingrese el nombre del checksum --> "chk_sum.txt": ' ARG2
             bash ./Descomprimir.sh "$ARG1" "$ARG2"
             ;;

        "Procesar.sh")
             bash ./Procesar.sh
             ;;

        "Comprimir.sh")
             bash ./Comprimir.sh
             ;;

        "Quit")
             echo "ADIOS!"
             break
             ;;

        *) echo "Opcion NO VALIDA" $REPLY
             ;;
   esac
done
