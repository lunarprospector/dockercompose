FROM alpine:latest
RUN apk update && \
    apk add mysql-client && \
    mkdir -p /shared && \
    mkdir -p /app

COPY ["init.sh", "/app/"]
COPY ["db.sql", "/shared/"]
ENTRYPOINT ["/bin/sh", "/app/init.sh"]
