# nginx-http-flv-docker
Docker image with Nginx using the [nginx-http-flv-module](https://github.com/winshining/nginx-http-flv-module) for live multimedia (video) streaming.

##How to use
>docker build -t nginx-http-flv .
docker run -d -p 1935:1935 -p 80:80 --name nginx-http-flv nginx-http-flv
##How to configure nginx
See the document of [nginx-http-flv-module](https://github.com/winshining/nginx-http-flv-module) and [nginx-rtmp-module](https://github.com/arut/nginx-rtmp-module)
You could start the container with customized configure file
>docker run -d -v my_nginx.conf:/usr/local/nginx/conf/nginx.conf -p 1935:1935 -p 80:80 --name nginx-http-flv nginx-http-flv
