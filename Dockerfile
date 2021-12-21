FROM alpine:3.15.0

WORKDIR /workdir
COPY package*.json ./
RUN adduser -u 2004 -D docker && apk --no-cache add openjdk11-jre-headless bash nodejs npm && npm install --production && apk del npm
COPY docs /docs
COPY target/universal/stage/ /workdir/
RUN chmod +x /workdir/bin/codacy-stylelint
USER docker
WORKDIR /src
ENTRYPOINT ["/workdir/bin/codacy-stylelint"]
