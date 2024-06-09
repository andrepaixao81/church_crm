FROM php:8.1-apache

# Instalar dependências necessárias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Instalar extensões PHP necessárias
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Baixar e configurar o ChurchCRM
RUN apt-get update && apt-get install -y git unzip
RUN git clone https://github.com/ChurchCRM/CRM.git /var/www/html/
RUN chown -R www-data:www-data /var/www/html/
RUN chmod -R 755 /var/www/html/

# Configurar Apache
RUN a2enmod rewrite

# Expor a porta 80
EXPOSE 80
