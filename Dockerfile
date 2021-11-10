FROM alpine:latest
RUN apk update && \
    apk add mysql-client

COPY ["test.sh", "/tmp/"]
COPY ["db.sql", "/tmp/"]
CMD ["/bin/sh", "/tmp/test.sh"]
