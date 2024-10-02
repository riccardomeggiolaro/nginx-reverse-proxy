# Usa l'immagine di base Debian
FROM debian:latest

# Installa NGINX e OpenSSL
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# Copia il file di configurazione reverse-proxy.conf
COPY conf.d/reverse-proxy.conf /etc/nginx/sites-available/reverse-proxy.conf

# Disabilita il sito di default e abilita il reverse proxy
RUN rm -f /etc/nginx/sites-enabled/default && \
    ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/

# Copia i certificati SSL (se disponibili)
COPY conf.d/cert.pem /etc/nginx/conf.d/cert.pem
COPY conf.d/key.pem /etc/nginx/conf.d/key.pem

# Espone la porta 443
EXPOSE 443

# Avvia NGINX
CMD ["nginx", "-g", "daemon off;"]