FROM node:14 AS base

WORKDIR /app

FROM base AS node_modules

COPY package*.json ./

RUN npm ci

FROM node_modules AS build

COPY ./src src
COPY ./gatsby-node.js gatsby-node.js
COPY ./gatsby-config.js gatsby-config.js
COPY ./.prettierrc .prettierrc

RUN npm run build
RUN find public -type f -regex '.*\.\(htm\|html\|txt\|text\|js\|css\)$' -exec gzip -f -k {} \;

FROM scratch AS artifacts

COPY --from=build /app/public /
