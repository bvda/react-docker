# Official Docker images
# https://hub.docker.com/_/node
# https://hub.docker.com/_/nginx
# Remember only to use official images. More work, but also more security ;)

# Build stage
FROM node as build
WORKDIR /app
COPY . .
RUN yarn && yarn build

# Deploy stage
FROM nginx
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=build /app/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]

# Probably not production ready (Nginx not configured).