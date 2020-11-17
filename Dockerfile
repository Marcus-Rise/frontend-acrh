ARG NODE_VERSION=14

FROM node:${NODE_VERSION} AS dev
USER node
WORKDIR /app
ENV CI true

CMD npm install \
    && npm run develop
