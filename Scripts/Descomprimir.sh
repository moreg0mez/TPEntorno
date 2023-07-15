#!/bin/bash

#Cambio al directorio donde deben estar el .zip y el .txt
cd ..

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

#Borro las imagenes anteriores y descomprimo el zip
rm -r imagenes_tp
unzip imagenes_tp.zip
echo "Las imagenes fueron descomprimidas exitosamente"

exit 0




