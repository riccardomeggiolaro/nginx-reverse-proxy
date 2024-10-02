docker build -t nginx-reverse-proxy .

docker run --network host -d -p 443:443 --name nginx-reverse-proxy -e "ROOT_PASSWORD=3181" nginx-reverse-proxy

docker exec -it nginx-reverse-proxy bash