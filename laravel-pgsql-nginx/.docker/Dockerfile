FROM php:8.4-fpm-alpine

ARG UID
ARG GID

ENV UID=${UID}
ENV GID=${GID}

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN apk add --no-cache \
    curl \
    libxml2-dev \
    php-soap \
    libzip-dev \
    unzip \
    zip \
    libpng \
    libpng-dev \
    jpeg-dev \
    oniguruma-dev \
    curl-dev \
    freetype-dev \
    libpq-dev \
    bash \
    supervisor \
    postgresql-client \
    linux-headers \ 
    nginx

RUN docker-php-ext-install pgsql pdo pdo_pgsql mbstring exif zip soap bcmath curl zip opcache sockets posix

RUN docker-php-ext-configure pcntl --enable-pcntl \
    && docker-php-ext-install pcntl

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

COPY ./.docker/nginx.conf /etc/nginx/http.d/default.conf
COPY ./.docker/supervisord.conf /etc/supervisord.conf

COPY --chown=laravel:laravel . .
RUN composer install --no-interaction --optimize-autoloader 
# Set correct permissions
RUN chmod -R 777 /var/www/html/storage /var/www/html/bootstrap/cache

EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
# CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]


