FROM node:12

RUN apt-get update ;\
  apt-get upgrade -y ;\
  apt-get install -y ffmpeg perl sqlite3 dcraw libjpeg-turbo-progs build-essential python2.7-dev ;\
  apt-get autoremove -y ;\
  apt-get autoclean -y

# https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /ps/app

COPY package.json yarn.lock ./

RUN npx yarn install

COPY . .

EXPOSE 1787

# These environment variables tell PhotoStructure the volume mountpoints that
# are configured in docker-compose.yml:
ENV XDG_CONFIG_HOME="/ps/config"
ENV PS_LOG_DIR="/ps/logs"
ENV PS_LIBRARY_PATH="/ps/library"
ENV PS_DOCKER="1"

# These volume paths are configured in docker-compose.yml, using values set by
# photostructure.env. 
VOLUME ["/ps/config", "/ps/logs", "/ps/library"]

HEALTHCHECK CMD curl -f http://localhost:1787/ping || exit 1

ENTRYPOINT [ "node", "/ps/app/photostructure" ]