# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gavril <gavril@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/03 13:50:13 by gavril            #+#    #+#              #
#    Updated: 2021/02/11 21:25:26 by gavril           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

LABEL maintainer="gavril@student.21-school.ru"

RUN apt-get -y update && apt-get -y upgrade && \
	apt-get install -y php-fpm php-mysql nginx mariadb-server openssl wordpress

COPY srcs/autoindex.sh /

# OpenSSL
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=RF/ST=MSK/L=SCH/O=21/CN=gavril' \
	-keyout /etc/ssl/certs/nginx.key -out /etc/ssl/certs/nginx.crt && chmod +x autoindex.sh

# NGINX
COPY ./srcs/default /etc/nginx/sites-enabled/default

# PHPMYADMIN
ADD https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz phpmyadmin.tar.gz
RUN tar xvzf phpmyadmin.tar.gz && mv phpMyAdmin-5.0.2-all-languages /var/www/html/phpmyadmin
COPY ./srcs/config.inc.php /var/www/html/phpmyadmin/

#WordPress
RUN mv /usr/share/wordpress /var/www/html

COPY ./srcs/wp-config.php /var/www/html/wordpress/
COPY /srcs/database.sql /tmp/database.sql
COPY srcs/start.sh /

CMD bash start.sh
