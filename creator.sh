#Dos Script similares, el primero arranca el nginx y el segundo el apache.

#!/bin/bash

#en las siguentes lineas borraremos los contenedores.
docker rm -f datacontainer
docker rm -f mdb
docker rm -f nginx
docker rm -f wordpress
docker rm -f torrent

#aqui crearemos los contenedores y haremos el "reenvio" de puertos.
docker create --name=mdb -e MYSQL_ROOT_PASSWORD=mariadb -e MYSQL_DATABASE1=moodle -e MYSQL_USER1=moodle -e MYSQL_PASSWORD1=moodle -v datos:/var/lib/mysql orboan/dcsss-mariadb

docker create --name wordpress -p 8081:80 -v datos:/workspace/ wordpress

docker create -v datos:/var/www/html/ --name nginx -p 8080:80 yreyes/nginx

docker create --volumes-from nginx --volumes-from mdb --volumes-from wordpress --name datacontainer centos

#La aplicación web que he implementado es esta (una web donde se pueden descargar ficheros torrent)
docker create --name torrent -p 8082:80 -p 49160:49160/udp -p 49161:49161 -v datos:/home diameter/rtorrent-rutorrent:latest

#aqui arrancaremos los contenedores.
docker start torrent
docker start mdb
docker start nginx
docker start wordpress


#Exercici 2 (35%)

#!/bin/bash

docker rm -f datacontainer
docker rm -f mdb
docker rm -f httpd
docker rm -f wordpress

docker create --name=mdb -e MYSQL_ROOT_PASSWORD=mariadb -e MYSQL_DATABASE1=moodle -e MYSQL_USER1=moodle -e MYSQL_PASSWORD1=moodle -v datos:/var/lib/mysql orboan/dcsss-mariadb

docker create -v datos:/var/www/html/ --name httpd -p 8080:80 yreyes/httpd

docker create --name wordpress -p 8081:80 -v datos:/workspace/ wordpress

docker create --volumes-from httpd --volumes-from mdb --volumes-from wordpress --name datacontainer centos

docker start mdb
docker start httpd
