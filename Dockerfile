# Para atualizar, consulte: https://hub.docker.com/_/joomla

FROM joomla:5.1.2-php8.1-apache

RUN apt-get update && apt-get install -y nano && apt-get clean

ARG TIMEZONE="America/Sao_Paulo"
ENV TZ=$TIMEZONE

# Instala Node.js e npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

EXPOSE 80

CMD ["apache2-foreground"]