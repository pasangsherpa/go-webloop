FROM heroku/go-base:latest
MAINTAINER Pasang Sherpa <pgsherpa12@gmail.com>

RUN mkdir -p /app/.cache/gotools /app/.profile.d

ENV GOPATH /app/.cache/gotools
ENV PATH $GOPATH/bin:$PATH

# Install xvfb (x session), libwebkit, gtk, and gotk3
RUN apt-get update -y \
  && apt-get install --no-install-recommends -yq \
    xvfb \
    libwebkit2gtk-3.0-dev \
    libgtk-3-dev \
    libcairo2-dev \
  && go get -v github.com/tools/godep \
  && go get -u -tags gtk_3_10 github.com/pasangsherpa/webloop/... \
	&& curl -s --retry 3 -L https://github.com/stedolan/jq/releases/download/jq-1.4/jq-linux-x86_64 -o $GOPATH/bin/jq \
	&& chmod a+x $GOPATH/bin/jq

ENV GOPATH /app/user
ENV PATH $GOPATH/bin:$PATH

COPY ./compile /app/.cache/gotools/bin/compile
COPY ./init.sh /opt/init.sh
RUN chmod +x /opt/init.sh

ONBUILD COPY . /app/.temp
ONBUILD RUN /app/.cache/gotools/bin/compile
ONBUILD CMD ["/opt/init.sh"]
