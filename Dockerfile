FROM alpine:latest
RUN apk update && \
    apk add mysql-client

COPY ["init.sh", "/tmp/"]
COPY ["db.sql", "/tmp/"]
ENTRYPOINT ["/bin/sh", "/tmp/init.sh"]
