FROM dnxza/lemp:latest

MAINTAINER DNX DragoN "ratthee.jar@hotmail.com"

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
&& php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
&& php composer-setup.php \
&& php -r "unlink('composer-setup.php');"
	
RUN rm -Rf /etc/nginx/conf.d/default.conf
ADD conf/nginx-site.conf /etc/nginx/conf.d/default.conf

RUN //composer.phar create-project --prefer-dist laravel/laravel /usr/share/nginx/laravel

RUN chown -Rf www-data /usr/share/nginx/laravel && chgrp -R www-data /usr/share/nginx/laravel && chmod -R g+w /usr/share/nginx/laravel

CMD [ "/bin/bash", "/start.sh", "start" ]