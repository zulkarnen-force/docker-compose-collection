FROM nginx:1.28
RUN apt-get update && apt-get install -y \
     nano \
     certbot \
     python3-certbot-nginx \
     cron \
    && rm -rf /var/lib/apt/lists/* 
RUN mkdir -p /var/www/html/.well-known/acme-challenge \
     && chown -R www-data:www-data /var/www/html
CMD ["nginx", "-g", "daemon off;"]
