FROM heroku/go-base:1.5
MAINTAINER Pasang Sherpa <pgsherpa12@gmail.com>

RUN mkdir -p /app/.cache/gotools /app/.profile.d

ENV GOPATH /app/.cache/gotools
ENV PATH /app/user/bin:$GOPATH/bin:$PATH
ENV DISPLAY :0.0

# Install xvfb (x session), libwebkit, gtk, and gotk3
RUN apt-get update -y \
  && apt-get install --no-install-recommends -yq \
    xvfb \
    libwebkit2gtk-3.0-dev \
    libgtk-3-dev \
    libcairo2-dev \
  && go get -v github.com/tools/godep \
  && curl -s --retry 3 -L https://github.com/stedolan/jq/releases/download/jq-1.4/jq-linux-x86_64 -o $GOPATH/bin/jq \
  && chmod a+x $GOPATH/bin/jq

ENV GOPATH /app/user

COPY ./compile /app/.cache/gotools/bin/compile
RUN chmod a+x /app/.cache/gotools/bin/compile
COPY ./init /app/.cache/gotools/bin/init
RUN chmod a+x /app/.cache/gotools/bin/init

ONBUILD COPY . /app/.temp
ONBUILD RUN /app/.cache/gotools/bin/compile
ONBUILD RUN /app/.cache/gotools/bin/init