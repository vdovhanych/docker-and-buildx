# set docker and buildx versions to be downloaded
ARG BUILDX_VERSION=0.7.1
ARG DOCKER_VERSION=latest

FROM alpine AS fetcher

# install necessary packages
RUN apk add curl

# add buildx binaries
ARG BUILDX_VERSION
RUN curl -L \
  --output /docker-buildx \
  "https://github.com/docker/buildx/releases/download/v${BUILDX_VERSION}/buildx-v${BUILDX_VERSION}.linux-amd64"

RUN chmod a+x /docker-buildx
# add docker 
ARG DOCKER_VERSION
FROM docker:${DOCKER_VERSION}

COPY --from=fetcher /docker-buildx /usr/lib/docker/cli-plugins/docker-buildx