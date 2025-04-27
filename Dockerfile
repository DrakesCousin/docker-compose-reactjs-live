FROM oven/bun:latest

RUN apt-get update \
    && apt-get install -y nginx git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ENV APP_DIR=/app
RUN mkdir -p $APP_DIR/build
WORKDIR $APP_DIR

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN sed -i 's/\r$//' /entrypoint.sh

COPY nginx.conf /etc/nginx/sites-available/default

EXPOSE 80

RUN pwd

RUN ls -al

ENTRYPOINT ["sh", "/entrypoint.sh"]
