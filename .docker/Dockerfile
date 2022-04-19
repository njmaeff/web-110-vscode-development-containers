FROM wordpress:5.9.2-php8.1


RUN apt-get update \
    && apt-get install -y git vim sudo

# configure php tools
RUN mkdir /usr/local/etc/php/xdebug \
    && pecl install -f xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/xdebug.ini

# install composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Add WP-CLI 
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && php wp-cli.phar --info \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

ARG USER_ID=1000
ARG GROUP_ID=1000
# update the user for linux usage
RUN groupadd -g ${GROUP_ID} vscode \
    && useradd -s /bin/bash --uid ${USER_ID} --gid ${GROUP_ID} -m vscode \
    && usermod -aG vscode www-data\
    && echo vscode ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/vscode \
    && chmod 0440 /etc/sudoers.d/vscode \
    && chown -R vscode:vscode /var/www

COPY .docker/scripts/ /docker/
# RUN bash /docker/setup.sh
USER vscode

# install nodejs
RUN bash /docker/nvm.sh

ENTRYPOINT [ "bash", "/docker/entrypoint.sh"]
