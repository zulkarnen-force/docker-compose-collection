# Dockerfile for nextjs with multistage
ARG NODE_VERSION=20-alpine

FROM node:$NODE_VERSION AS base
WORKDIR /app

FROM base AS deps
COPY package*.json .
RUN npm install

FROM base AS builder
COPY --from=deps /app/node_modules /app/node_modules
COPY . .
RUN npm run build

FROM base AS development
COPY --from=deps /app/node_modules /app/node_modules
COPY . .
CMD [ "npm", "run", "dev" ]

FROM base AS production
COPY --from=deps /app/node_modules /app/node_modules
COPY --from=builder /app/.next /app/.next
COPY --from=builder /app/package.json /app/package.json
CMD [ "npm", "run", "start" ]