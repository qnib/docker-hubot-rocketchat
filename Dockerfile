FROM qnib/d-node

#### Inspired by
# https://github.com/RocketChat/hubot-rocketchat/blob/master/Dockerfile
RUN npm install -g coffee-script yo generator-hubot  &&  \
	useradd hubot -m

USER hubot

WORKDIR /home/hubot

ENV DEV false

ENV BOT_NAME "bot"
ENV BOT_OWNER "Christian Kniep <christian@qnib.org>"
ENV BOT_DESC "Hubot with rocketbot adapter"

ENV EXTERNAL_SCRIPTS=hubot-diagnostics,hubot-help,hubot-google-images,hubot-google-translate,hubot-maps,hubot-rules,hubot-shipit,hubot-grafana,hubot-graphme,hubot-business-cat,hubot-tell

RUN yo hubot --owner="$BOT_OWNER" --name="$BOT_NAME" --description="$BOT_DESC" --defaults && \
	sed -i /heroku/d ./external-scripts.json && \
	sed -i /redis-brain/d ./external-scripts.json && \
	npm install hubot-rocketchat

RUN node -e "console.log(JSON.stringify('$EXTERNAL_SCRIPTS'.split(',')))" > external-scripts.json && \
	npm install $(node -e "console.log('$EXTERNAL_SCRIPTS'.split(',').join(' '))") && \
	if $DEV; then coffee -c /home/hubot/node_modules/hubot-rocketchat/src/*.coffee; fi 
CMD	bin/hubot -n $BOT_NAME -a rocketchat

