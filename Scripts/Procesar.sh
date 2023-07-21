#!/bin/bash

#Navegamos hasta la carpeta donde está imagenes_tp
cd ..

#En caso de que se intente ejecuar dos veces el script Procesar.sh, se retorna error
[ -e imagenes_tp_procesadas ] && echo "ERROR: La carpeta imagenes_tp_procesadas ya existe, continue con la opcion 4)" && exit 1

#Verificamos que exista, en caso contrario retornamos un mensaje de error.
if [ -e imagenes_tp ]; then
   echo "La carpeta de imagenes existe... procesando imagenes..."
else
   echo -e "ERROR: La carpeta de imagenes NO EXISTE. Antes ejecute 1) o 2)\n"
   exit 1
fi

#Aclaramos que no es necesario incluir argumentos, ya que el script solo necesita ser
#ejecutado para procesar las imagenes
[ "$#" -ne 0 ] && echo "Ejecute el script sin argumentos" && exit 1

#Creo la nueva carpeta en la cual se guardarán las imagenes procesadas
mkdir imagenes_tp_procesadas

#Se inicia un loop for para iterar sobre las imagenes de imagenes_tp
for i in ./imagenes_tp/* # El wildcard toma todos los nombres
do                       # de archivo, luego basename deja SOLO el nombre del archivo
   NOMBRE=$(basename "$i")
                                            # =~ compara el Nombre con la expresion regular para verificar
   if [[ "$NOMBRE" =~ ^[A-ZÑ][a-zñ]+ ]]; then #que empiece con mayuscula y siga con minusculas.
      convert "./imagenes_tp/$NOMBRE" -gravity center -resize 512x512+0+0 -extent 512x512 "./imagenes_tp_procesadas/$NOMBRE"
      echo "Imagen procesada, aguarde..."
   else continue
   fi

done

echo "Todas las imagenes fueron procesadas y guardadas en imagenes_tp_procesadas"

#Imprimimos menu
echo -e "Lista de opciones:" 
echo -e "1) Generar.sh" 
echo -e "2) Descomprimir.sh"
echo -e "3) Procesar.sh"
echo -e "4) Comprimir.sh"
echo -e "5) Quit" 

exit 0
