FROM node:14.16.0-buster as builder
# run yarn build in this container

WORKDIR /temp

RUN chmod 1777 /tmp

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential python --no-install-recommends 

ADD . .
RUN yarn install \
    && yarn build

FROM node:14.16.0-alpine as prod

WORKDIR /app

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone 

ADD . .
RUN yarn install --production

# copy the yarn build files in here
COPY --from=builder /temp/dist ./dist

EXPOSE 80

CMD ["node", "-r", "dotenv/config", "dist"]