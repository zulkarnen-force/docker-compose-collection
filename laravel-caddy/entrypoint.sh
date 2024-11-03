#!/bin/bash
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile 
php-fpm -D