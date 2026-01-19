FROM php:8.2-apache

# Dependencias del sistema
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    curl

# Extensiones PHP para Laravel
RUN docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl bcmath gd

# Apache rewrite
RUN a2enmod rewrite

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copiar proyecto
COPY . /var/www/html

# Instalar dependencias PHP
RUN composer install --no-dev --optimize-autoloader

# Permisos Laravel
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# DocumentRoot -> /public
RUN sed -i 's|/var/www/html|/var/www/html/public|g' \
    /etc/apache2/sites-available/000-default.conf

# Storage link
RUN php artisan storage:link || true
