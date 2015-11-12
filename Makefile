TAGS=latest
NAME=qnib/hubot-rocketchat

include ~/src/github.com/ChristianKniep/QNIBTerminal/docker.mk

all: build

up:
	docker-compose up -d consul mongodb
	sleep 5
	docker-compose up -d rocketchat
	sleep 2
	docker-compose up -d hubot

rm:
	docker-compose kill
	docker-compose rm --force
