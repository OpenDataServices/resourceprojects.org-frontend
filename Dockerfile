FROM php:5.6-apache

# Install git
RUN apt-get update
RUN apt-get install -y git sqlite3

# Enable apache's rewrite module
RUN a2enmod rewrite

# Remove default apache page
RUN rm /var/www/html/index.html

# Clone the lodspeakr repository
RUN git clone https://github.com/alangrafu/lodspeakr.git /var/www/html/lodspeakr

# Run the install script
RUN cd /var/www/html/lodspeakr; ./install.sh base-url=http://lodspeakr.nrgi-dev.default.opendataservices.uk0.bigv.io/ base-namespace=http://virtuoso.nrgi-dev.default.opendataservices.uk0.bigv.io/ sparql-endpoint=http://virtuoso:8890/sparql
# Create some directories and make them writeable by apache
RUN chown -R www-data /var/www/html/lodspeakr/cache /var/www/html/lodspeakr/meta /var/www/html/lodspeakr/components

ADD components/services /var/www/html/lodspeakr/components/services

# expose the HTTP port to the outer world
EXPOSE 80
