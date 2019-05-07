FROM node:8-stretch
RUN apt-get update && apt-get upgrade -y && apt-get install -y build-essential redis-server libpng-dev git python-minimal libvhdi-utils lvm2 cifs-utils
RUN git clone -b master --depth 1 http://github.com/vatesfr/xen-orchestra
COPY start.sh /start.sh
WORKDIR /xen-orchestra
RUN yarn && yarn build
WORKDIR /xen-orchestra/packages/xo-server
RUN sed "/http.mount/a'/' = '../xo-web/dist/'" sample.config.toml > .xo-server.toml

VOLUME /var/lib/xo-server

CMD ["/start.sh"]
