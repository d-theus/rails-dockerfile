FROM dtheus/ruby:2.2-alpine
MAINTAINER Andrew Dorofeyev (http://github.com/d-theus)


ENV BUILD_PACKAGES="ruby-dev build-base" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev sqlite-dev postgresql-dev mysql-dev" \
    RAILS_VERSION="4.2"

RUN apk --update --upgrade add $BUILD_PACKAGES $DEV_PACKAGES

RUN gem install bundler -N && \
    gem install -N nokogiri -- --use-system-libraries && \
    gem install rails -N -v $RAILS_VERSION

RUN echo 'gem: --no-document' >> ~/.gemrc && \
    cp ~/.gemrc /etc/gemrc && \
    chmod uog+r /etc/gemrc && \
    bundle config --global build.nokogiri  "--use-system-libraries" && \
    bundle config --global build.nokogumbo "--use-system-libraries" && \
    find / -type f -iname \*.apk-new -delete && \
    rm -rf /var/cache/apk/* && \
    rm -rf /usr/lib/lib/ruby/gems/*/cache/* && \
    rm -rf ~/.gem

EXPOSE 3000

