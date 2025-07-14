# see versions at https://hub.docker.com/_/ghost
FROM ghost:5.14.1

WORKDIR $GHOST_INSTALL
COPY . .
COPY config.production.json /var/lib/ghost/config.production.json

ENTRYPOINT []
CMD ["./start.sh"]
