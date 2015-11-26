#!/bin/bash

DELAY=30
echo "Sleep ${DELAY}s to wait for RocketChat to come up"
sleep ${DELAY}

cd /home/hubot/
./bin/hubot -n $BOT_NAME -a rocketchat

