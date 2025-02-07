# Gunakan image PHP dengan ekstensi yang diperlukan
FROM php:8.3-fpm

# Install dependensi
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    git \
    curl \
    libicu-dev \
    && docker-php-ext-install pdo pdo_mysql zip gd intl

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy seluruh file ke dalam container
COPY . .

# Install dependensi Laravel
RUN composer install --no-dev --optimize-autoloader

# Berikan permission ke storage dan bootstrap/cache
RUN chmod -R 777 storage bootstrap/cache

# Expose port
EXPOSE 9000

CMD ["php-fpm"]
