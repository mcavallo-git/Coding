# ------------------------------------------------------------
#
#  Build this Dockerfile: See parent docker-compose file
#
#    >   docker-compose --file="docker-compose.yml" up --build -d;
#
# ------------------------------------------------------------
#
# ARG - Ingest build-time arguments from the command line or docker-compose.yml file  -  https://docs.docker.com/engine/reference/builder/#arg
#

ARG NGINX_IMAGE_NAME=library/nginx

ARG NGINX_IMAGE_TAG=alpine

# ------------------------------------------------------------

FROM ${NGINX_IMAGE_NAME}:${NGINX_IMAGE_TAG}

# ------------------------------------------------------------
#
# NOTE: ARG used after the FROM instruction must be declared after it  -  https://stackoverflow.com/a/58697226
#

ARG NGINX_CONFIG_ROOT=/etc/nginx

ARG NGINX_WEBROOT=/usr/share/nginx/html/

# ------------------------------------------------------------

# Comment-out any "access_log" directives found in NGINX's global config file (Note: Usage of the "access_log" directive at the "http" scope blocks the use of the "log_format" directive at the "server" scope - just make sure to define it at the "server" scope)
RUN sed -re "/^\s*access_log.+$/ s/^#*/# /" -i "${NGINX_CONFIG_ROOT}/nginx.conf"


# Copy web server source-file(s) into the docker container
RUN rm -rfv "${NGINX_WEBROOT}/index.html";
COPY ".${NGINX_WEBROOT}" "${NGINX_WEBROOT}"


# Copy NGINX web server configuration templates into the docker container
RUN rm -rfv "${NGINX_CONFIG_ROOT}/conf.d/default.conf";
COPY ".${NGINX_CONFIG_ROOT}/templates/" "${NGINX_CONFIG_ROOT}/templates/"


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.docker.com  |  "docker build | Docker Documentation"  |  https://docs.docker.com/engine/reference/commandline/build/
#
#   docs.docker.com  |  "Dockerfile reference | Docker Documentation"  |  https://docs.docker.com/engine/reference/builder/#copy
#
#   docs.docker.com  |  "Overview of docker-compose CLI | Docker Documentation"  |  https://docs.docker.com/compose/reference/
#
#   hub.docker.com  |  "Nginx - Official Image | Docker Hub"  |  https://hub.docker.com/_/nginx?tab=description&page=1&ordering=last_updated
#
#   stackoverflow.com  |  "Pass args to the Dockerfile from docker-compose - Stack Overflow"  |  https://stackoverflow.com/a/58697226
#
# ------------------------------------------------------------