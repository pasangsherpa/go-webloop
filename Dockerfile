FROM ubuntu
MAINTAINER Pasang Sherpa <pgsherpa12@gmail.com>

# Set environment vars
ENV GO_VERSION go1.5
ENV EXTENSION linux-amd64.tar.gz
ENV GOPATH /go
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin
ENV GOSRC $GOPATH/src
ENV APP app

# Install go deps, xvfb (x session), libwebkit, gtk, and gotk3
RUN apt-get update -y \
  && apt-get install --no-install-recommends -yq \
    wget \
    build-essential \
    ca-certificates \
    git \
    mercurial \
    bzr \
    dbus \
    xvfb \
    libwebkit2gtk-3.0-dev \
    libgtk-3-dev \
    libcairo2-dev \
  && wget https://storage.googleapis.com/golang/${GO_VERSION}.${EXTENSION} -o /tmp/${GO_VERSION}.${EXTENSION} \
  && tar -zxvf ${GO_VERSION}.${EXTENSION} -C /usr/local \
  && rm ${GO_VERSION}.${EXTENSION} \
  && mkdir $HOME/go \
  && go get -u -tags gtk_3_10 github.com/pasangsherpa/webloop/...

COPY ./init.sh /opt/init.sh
RUN chmod a+x /opt/init.sh

ONBUILD WORKDIR $GOSRC/$APP
ONBUILD ADD . $GOSRC/$APP/
ONBUILD RUN go get $APP

ONBUILD CMD ["/bin/bash", "/opt/init.sh"]