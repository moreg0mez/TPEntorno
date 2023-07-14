#!/bin/bash


#Aca se usa un condicional "and" para que se cumplan dos cosas: 1) que se ingrese 1 solo argumento
# y 2) que sea un numero.

if ([ $# -eq 1 ] && [[ $1 =~ ^[0-9]+$ ]]); then
  echo "Input correcto, aguarde un momento"
  exit 0

else
  echo  "Input no valido, ingrese un numero"

fi

#Creo el directorio en donde se guardaran las imagenes del Tp del grupo 3 (tpg3)
# y cambio el working directory a ese directro
mkdir imagenes_tp
cd imagenes_tp


