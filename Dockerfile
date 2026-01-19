FROM php:8.2-apache

# Instalar extensiones necesarias
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Habilitar mod_rewrite (Laravel lo necesita)
RUN a2enmod rewrite

# Copiar el proyecto
COPY . /var/www/html

# Permisos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# DocumentRoot a /public (Laravel)
RUN sed -i 's|/var/www/html|/var/www/html/public|g' \
    /etc/apache2/sites-available/000-default.conf
