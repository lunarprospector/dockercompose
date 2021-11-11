FROM alpine:latest
RUN apk update && \
    apk add mysql-client && \
    mkdir -p /app

COPY ["init.sh", "/app/"]
COPY ["db.sql", "/app/"]
ENTRYPOINT ["/bin/sh", "/app/init.sh"]
