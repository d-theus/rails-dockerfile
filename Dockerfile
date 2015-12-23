# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM centos:centos7
MAINTAINER d-theus(http://github.com/d-theus)
RUN cat /etc/yum/pluginconf.d/fastestmirror.conf  | sed 's/enabled=1/enabled=0/g' > /etc/yum/pluginconf.d/fastestmirror.conf
RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel
RUN yum -y install ImageMagick
RUN yum clean all

RUN useradd web
USER web
ENV HOME /home/web
RUN mkdir -p /home/web/app
WORKDIR /home/web/app

RUN git clone git://github.com/sstephenson/rbenv.git $HOME/.rbenv
ENV RBENV_DIR $HOME/.rbenv
ENV PATH $RBENV_DIR/bin:$PATH
RUN eval "$(rbenv init -)"
RUN mkdir -p $RBENV_DIR/plugins
RUN git clone https://github.com/rbenv/rbenv-vars.git $RBENV_DIR/plugins/rbenv-vars
RUN git clone git://github.com/sstephenson/ruby-build.git $RBENV_DIR/plugins/ruby-build
ENV PATH $RBENV_DIR/plugins/ruby-build/bin:$PATH

RUN rbenv install -v 2.2.0
RUN rbenv global 2.2.0

RUN rbenv exec gem install rails -v 4.1.7
EXPOSE 3000

# Project specific image Docker file should contain the following
# FROM dtheus/rails
# RUN yum -y update; yum -y install ImageMagick postgresql-server postgresql-contrib postgresql-devel; yum clean all;
# rbenv exec bunlde install
# ...

