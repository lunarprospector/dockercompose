FROM alpine:latest
RUN apk update && \
    apk add mysql-client

COPY ["test.sh", "/tmp/"]
COPY ["db.sql", "/tmp/"]
<<<<<<< HEAD
CMD ["/bin/sh", "/tmp/test.sh"]
=======
ENTRYPOINT ["/bin/sh", "/tmp/init.sh"]
>>>>>>> main
