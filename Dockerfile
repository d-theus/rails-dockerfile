FROM centos:centos7

ARG rails_version=4.1.7
ARG ruby_version=2.2.0
ARG user=web

MAINTAINER d-theus(http://github.com/d-theus)
RUN cat /etc/yum/pluginconf.d/fastestmirror.conf  | sed 's/enabled=1/enabled=0/g' > /etc/yum/pluginconf.d/fastestmirror.conf
RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel postgresql-server postgresql-contrib postgresql-devel ImageMagick; yum clean all

RUN useradd $user
USER $user
ENV HOME /home/$user
RUN mkdir -p $HOME/app
WORKDIR $HOME/app

RUN git clone git://github.com/sstephenson/rbenv.git $HOME/.rbenv
ENV RBENV_ROOT $HOME/.rbenv
ENV PATH $RBENV_ROOT/bin:$PATH
RUN eval "$(rbenv init -)"
RUN mkdir -p $RBENV_ROOT/plugins
RUN git clone https://github.com/rbenv/rbenv-vars.git $RBENV_ROOT/plugins/rbenv-vars; git clone git://github.com/sstephenson/ruby-build.git $RBENV_ROOT/plugins/ruby-build
ENV PATH $RBENV_ROOT/plugins/ruby-build/bin:$PATH
ENV RUBY_CONFIGURE_OPTS=--disable-install-doc

RUN rbenv install -v $ruby_version
RUN rbenv global $ruby_version

RUN rbenv exec gem install rails -v $rails_version --no-ri --no-rdoc


EXPOSE 3000


