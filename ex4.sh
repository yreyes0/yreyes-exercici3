  
#!/bin/bash

docker rm -f mariadb-server
docker rm -f moodle
docker rm -f datacontainer
docker network rm moodle-tier
docker network create moodle-tier

#se crea el contenedor de mariadb redireccionando al puerto 3306
docker create --name mariadb-server -p 3306:3306 -e ALLOW_EMPTY_PASSWORD=yes -e MARIADB_USER=bn_moodle -e MARIADB_DATABASE=bd_moodle  --net moodle-tier -v mariadb-storage:/bitnami bitnami/mariadb:latest

#Se crea el contenedor del servicio web , en este caso el moodle 
docker create --name moodle -p 8080:80 -p 443:443 -e ALLOW_EMPTY_PASSWORD=yes -e MARIADB_HOST=mariadb-server -e MOODLE_DATABASE_USER=bn_moodle -e MOODLE_DATABASE_NAME=bd_moodle --net moodle-tier -v moodle-storage:/bitnami bitnami/moodle:3.8.1-ol-7-r24


docker run --volumes-from mariadb-server --volumes-from moodle --name datacontainer centos:7

docker start mariadb-server
docker start moodle
