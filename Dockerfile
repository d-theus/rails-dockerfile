FROM ruby:2.2-slim
MAINTAINER Andrew Dorofeyev (http://github.com/d-theus)

ENV RAILS_VERSION 4.2
ENV RUBY_BUILD_DEPS "autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev libxml2-dev libxslt-dev"

RUN apt-get update && apt-get install -y nodejs postgresql-client postgresql-dev libpq-dev $RUBY_BUILD_DEPS --no-install-recommends && \
      apt-get clean && \
      rm -rf /var/lib/apt-lists/*

RUN gem install bundler -N && \
    gem install pkg-config && \
    gem install -N nokogiri -- --use-system-libraries && \
    gem install rails -N -v $RAILS_VERSION

EXPOSE 3000

