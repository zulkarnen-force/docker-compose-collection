# Use a PHP image as the base
FROM php:7.4-fpm

# Install required dependencies
RUN apt-get update && apt-get install -y \
     curl \
     libpng-dev \
     libonig-dev \
     libxml2-dev \
     zip \
     unzip \
     git \
     && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

RUN apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' |  gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' |  tee /etc/apt/sources.list.d/caddy-stable.list
RUN  apt update
RUN  apt install caddy


# Copy Caddyfile
COPY .docker/Caddyfile /etc/caddy/Caddyfile
COPY .docker/entrypoint.caddy.sh /entrypoint.caddy.sh
RUN chmod +x /entrypoint.caddy.sh
# Expose ports
EXPOSE 80
ENTRYPOINT [ "/entrypoint.caddy.sh" ]
# Run Caddy and PHP-FPM
# CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
