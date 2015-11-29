#!/bin/bash

DELAY=${1-0}
if [ ${DELAY} -gt 0 ];then
    echo "Sleep ${DELAY}s to wait for RocketChat to come up"
    sleep ${DELAY}
fi

cd /home/hubot/
./bin/hubot -n $BOT_NAME -a rocketchat

