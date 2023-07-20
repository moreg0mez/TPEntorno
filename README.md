# TPEntorno
Trabajo práctico final Entorno de Programación - TUIA

__El siguiente trabajo tiene por finalidad poner en práctica los conocimientos adquiridos durante el cursado de la materia Entorno de Programación en el marco de la Tecnicatura en Inteligencia Artificial de la UNR, consistiendo el mismo en la generación de un contenedor Docker mediante el cual el usuario pueda procesar un lote de imágenes, según distintas opciones presentadas en un menú.__

Procederemos a detallar las instrucciones para su correcta implementación:

1. Verifique que su computadora tenga acceso a internet

2. Conceda permisos de Lectura, Escritura y Ejecución a "otros" en el directorio en donde se encuentra el Dockerfile. 

3. Ejecute el siguiente comando en el directorio donde se encuentra el Dockerfile

sudo docker build --tag tuia2023/tp_grupo3:1.0 .

4. Ejecute el siguiente comando para correr la imagen 

sudo docker run -it --name tp_grupo3_2023 -v ./imagenes_comprimidas_tp:/TPEntorno/imagenes_comprimidas_tp tuia2023/tp_grupo3:1.0

5. El archivo ZIP con las imágenes se guardará en el directorio "imagenes_comprimidas_tp" ubicado en la misma ruta que el archivo Dockerfile

## Detalles sobre opciones del menú

El usuario podrá seleccionar alguna de las siguientes opciones:
* generar.sh: Genera imágenes utilizando un servicios web, las comprime y finalmente genera un archivo con su suma de verificación.
* descomprimir.sh: se indican por argumento dos archivos (uno con las imágenes comprimidas y otro con una suma de verificación). En caso de que ocurra algún error, se informa al usuario de lo contrario se procede a descomprimir.
* procesar.sh: Recorta las imágenes a una resolución de 512*512. Solamente se procesan aquellas que poseen nombres de personas válidos, interpretándose por estos cualquier combinación de palabras que empiecen con una letra mayúscula y sigan por minúsculas.
* comprimir.sh: genera un archivo con la lista de nombres de todas las imágenes, otro archivo con la lista de nombres válidos, un tercero con el total de personas cuyo nombre finaliza con la letra A y por último, un comprimido que incluye aquellos generados en los items anteriores; y todas las imágenes. 