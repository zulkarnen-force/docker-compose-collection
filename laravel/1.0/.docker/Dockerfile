# Use the official PHP image with Apache
FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
     zip \
     unzip \
     git \
     curl \
     libpng-dev \
     libonig-dev \
     libxml2-dev \
     libzip-dev \
     libjpeg-dev \
     libfreetype6-dev \
     && docker-php-ext-configure gd --with-freetype --with-jpeg \
     && docker-php-ext-install gd pdo pdo_mysql mbstring zip exif pcntl bcmath opcache

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs
RUN npm install npm@latest -g
RUN npm install yarn -g
# Enable Apache Rewrite Module
RUN a2enmod rewrite

# Copy custom Apache configuration
COPY .docker/apache/laravel.conf /etc/apache2/sites-available/000-default.conf

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set permissions for Laravel
RUN chown -R www-data:www-data /var/www/html \
     && chmod -R 755 /var/www/html

# Copy existing application files
COPY . /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
