#!/bin/bash

SERVER_PATH="bin/gremlin-server.sh"
SERVER_CONF="conf/gremlin-server.yaml"

cd $HOME/apache-gremlin-server-$VERSION-incubating

if [ "$(ls -A /root/conf)" ]
then
    cp -rf /root/conf/* .
fi

$SERVER_PATH $SERVER_CONF
