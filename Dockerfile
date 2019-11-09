FROM node:12

RUN apt-get update ;\
  apt-get upgrade -y ;\
  apt-get install -y ffmpeg perl build-essentials python2.7-dev ;\
  apt-get autoremove -y ;\
  apt-get autoclean -y

# https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /ps/app

COPY package.json yarn.lock ./

RUN npx yarn install

# A .dockerignore file prevents mac and windows tools from being included in the
# docker image.
COPY . .

EXPOSE 1787

ENV XDG_CONFIG_HOME="/ps/config"
ENV PS_LOG_DIR="/ps/logs"
ENV PS_LIBRARY_PATH="/ps/library"
# Tell PhotoStructure we're running in a container:
ENV PS_DOCKER="1"

VOLUME ["/ps/config", "/ps/logs", "/ps/library"]

HEALTHCHECK CMD curl -f http://localhost:1787/ping || exit 1

ENTRYPOINT [ "node", "/ps/app/photostructure" ]