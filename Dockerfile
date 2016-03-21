##############################################
#
#
#
##############################################


FROM frolvlad/alpine-oraclejdk8:full

MAINTAINER Dylan Millikin <dmill@apache.org>

#update repo and download packages required
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.3/main" > /etc/apk/repositories
RUN apk --update add wget unzip bash

# handle env
ARG VERSION=3.1.1

ENV VERSION $VERSION

# Download the gremlin server required through this build
RUN wget --no-check-certificate -O $HOME/apache-gremlin-server-$VERSION-incubating-bin.zip http://archive.apache.org/dist/incubator/tinkerpop/$VERSION-incubating/apache-gremlin-server-$VERSION-incubating-bin.zip

RUN unzip $HOME/apache-gremlin-server-$VERSION-incubating-bin.zip -d $HOME/
RUN rm $HOME/apache-gremlin-server-$VERSION-incubating-bin.zip
RUN cd $HOME/apache-gremlin-server-$VERSION-incubating && bin/gremlin-server.sh -i org.apache.tinkerpop neo4j-gremlin $VERSION-incubating

VOLUME $HOME/conf

ADD files/run-server.sh /root/
RUN chmod +x $HOME/run-server.sh

EXPOSE 8182

ENTRYPOINT /root/run-server.sh

