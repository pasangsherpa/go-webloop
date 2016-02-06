FROM heroku/go-gb:1.5
MAINTAINER Pasang Sherpa <pgsherpa12@gmail.com>

# Install xvfb (x session), libwebkit, gtk, and gotk3
RUN apt-get update -y \
  && apt-get install --no-install-recommends -yq \
    xvfb \
    libwebkit2gtk-3.0-dev \
    libgtk-3-dev \
    libcairo2-dev \
  && go get -u -tags gtk_3_10 github.com/pasangsherpa/webloop/...

COPY ./init.sh /opt/init.sh
RUN chmod +x /opt/init.sh

CMD ["/opt/init.sh"]