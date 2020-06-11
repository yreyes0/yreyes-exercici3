#!/bin/bash


#Se eliminan los contenedores existentes
docker rm -f httpd
docker rm -f nginx
docker rm -f datacontainer

#Se crea el contenedor de httpd con el puerto 80 y el respectivo volumen 
docker run -d  -v datos:/var/www/html --name httpd -p 8080:80 yreyes/httpd

#Se crea el contenedor de nginx con el puerto 81 y el respectivo volumen
docker run -d -v datos:/usr/share/nginx/html --name nginx -p 8081:80 nginx

#Se crea pero no se inicia el datacontainer para alojar los datos de ambos contenedores 
docker create  --volumes-from httpd --volumes-from nginx --name datacontainer centos:7

#Se arrancan los contenedores 
docker start nginx
docker start httpd
docker start datacontainer
