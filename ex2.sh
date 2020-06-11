
#!/bin/bash

# docker rm -f datacontainer
docker rm -f torrent
# docker rm -f mdb
# docker rm -f nginx
# docker rm -f wordpress
#
# docker create --name=mdb -e MYSQL_ROOT_PASSWORD=mariadb -e MYSQL_DATABASE1=moodle -e MYSQL_USER1=moodle -e MYSQL_PASSWORD1=moodle -v datos:/var/lib/mysql orboan/dcsss-maria$
#
# docker create -v datos:/var/www/html/ --name nginx -p 8080:80 yreyes/nginx
#
# docker create --name wordpress -p 8081:80 -v datos:/workspace/ wordpress
#
# docker create --volumes-from nginx --volumes-from mdb --volumes-from wordpress --name datacontainer centos

docker create --name torrent -p 8082:80 -p 49160:49160/udp -p 49161:49161 -v datos:/home diameter/rtorrent-rutorrent:latest

docker start torrent
# docker start mdb
# docker start nginx
# docker start wordpress

