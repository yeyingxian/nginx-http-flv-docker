ARG NGINX_VERSION=1.14.2
ARG NGINX_HTTP_FLV_VERSION=1.2.5

FROM alpine:3.8 AS base

# Add Alpine Linux Chinese mirror
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main" > /etc/apk/repositories
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/community" >> /etc/apk/repositories
RUN apk add --no-cache pcre openssl


FROM base AS build
ARG NGINX_VERSION
ARG NGINX_HTTP_FLV_VERSION

RUN apk add build-base pcre-dev openssl-dev

WORKDIR /tmp
RUN \
    wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    tar xzf nginx-${NGINX_VERSION}.tar.gz && \
    wget https://github.com/winshining/nginx-http-flv-module/archive/v${NGINX_HTTP_FLV_VERSION}.tar.gz && \
    tar xzf v${NGINX_HTTP_FLV_VERSION}.tar.gz && \
    cd nginx-${NGINX_VERSION} && \
    ./configure --add-module=../nginx-http-flv-module-${NGINX_HTTP_FLV_VERSION} && \
    make && \
    make install


FROM base AS release
LABEL MAINTAINER YE Ying-xian <yeyingxian@163.com>
COPY --from=build /usr/local/nginx /usr/local/nginx
COPY nginx.conf /usr/local/nginx/conf/nginx.conf

EXPOSE 1935
EXPOSE 80

CMD ["/usr/local/nginx/sbin/nginx"]
