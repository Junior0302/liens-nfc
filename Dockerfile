FROM php:8.2-apache

# Enable useful Apache modules
RUN a2enmod rewrite headers

# App root
WORKDIR /var/www/html

# Copy project (app lives in subfolder liens-nfc)
COPY liens-nfc/ /var/www/html

# Ownership to web user
RUN chown -R www-data:www-data /var/www/html

# Harden Apache server signature
RUN sed -i 's/ServerTokens OS/ServerTokens Prod/' /etc/apache2/conf-available/security.conf \
 && sed -i 's/ServerSignature On/ServerSignature Off/' /etc/apache2/conf-available/security.conf \
 && a2enconf security

# Expose web port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]