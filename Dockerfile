FROM node:14.15.4 as build

RUN npm install -g react-scripts@4.0.1

ENV PATH /app/node_modules/.bin:$PATH
WORKDIR /app

COPY package-lock.json package.json ./
RUN npm ci

COPY ./ ./
RUN npm run build


# http server
FROM nginx:1.19.6

ADD ./nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /app/build /usr/share/nginx/html
