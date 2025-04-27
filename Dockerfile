FROM oven/bun:latest

RUN apt-get update \
    && apt-get install -y nginx git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ENV APP_DIR=/app
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
COPY nginx.conf /etc/nginx/sites-available/default

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
