#!/bin/bash

#Cambio al directorio donde deben estar el .zip y el .txt
cd ..

#Es para si se usa la opcion 2) dos veces seguidas, entonces tira ERROR
[ -e imagenes_tp ] && echo "ERROR: Las imagenes ya fueron descomprimidas continue con la opcion 3)" && exit 1 

#Esto ya esta en el menu pero lo pongo aca asi el script solo tambien hace las verificaciones
! [ -e imagenes_tp.zip ] && echo -e "ERROR: El archivo imagenes_tp.zip NO EXISTE, primero ejecute Generar.sh\n" && exit 1
! [ -e chk_sum.txt ] && echo -e "ERROR: El archivo chk_sum.txt NO EXISTE, primero ejecute Generar.sh\n" && exit 1

#esto quedo redundante pero no lo quiero tocar por las dudas
#Verifico que los argumentos sean correctos y que los archivos existan
if ([ "$1" == "imagenes_tp.zip" ] && [ -e imagenes_tp.zip ]); then
   echo "el archivo .zip existe, aguarde..."
else
   echo 'ERROR: El 1er argumento debe ser "imagenes_tp.zip" y debe existir. Cambie el argumento, si el error persiste ejecute Generar.sh'
   exit 1
fi

if ([ "$2" == "chk_sum.txt" ] && [ -e chk_sum.txt ]); then
   echo "el checksum existe, aguarde..."
else
   echo 'ERROR: El 2do argumento debe ser "chk_sum.txt" y debe existir. Cambie el argumento, si el error persiste ejecute Generar.sh'
   exit 1
fi

#Comparo el checksum guardado con el que genero ahora nuevamente. Uso cat y cut
#y luego md5sum para obtener ambos y los mando con un pipe al comando cut

echo "Verificando checksum, aguarde..."
SUM1=$(cat chk_sum.txt | cut -d" " -f1)            #Uso el comando cut para extrear solo el check sum: -d" " delimita en el epsacio
SUM2=$(md5sum imagenes_tp.zip | cut -d" " -f1)     #y -f1 hace output del primer campo o field, es decir solo el numero sin el
if [ "$SUM1" == "$SUM2" ]; then                    #nombre del archivo
   echo "NO ERRORS, checksum verificado, se procede a descomprimir"
else
   echo "ERROR: LAS CHECKSUMS NO SON IGUALES, EJECUTE GENERAR.SH DE NUEVO"
   rm chk_sum.txt
   rm imagenes_tp.zip
   rm -r imagenes_tp
   exit 1
fi


unzip imagenes_tp.zip
echo "Las imagenes fueron descomprimidas exitosamente"

#Imprimimos nuevamente el menu para facilitar la eleccion de opciones
echo -e "Lista de opciones:" 
echo -e "1) Generar.sh" 
echo -e "2) Descomprimir.sh"
echo -e "3) Procesar.sh"
echo -e "4) Comprimir.sh"
echo -e "5) Quit" 

exit 0




