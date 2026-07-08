FROM ruby:3.4-bullseye AS build

WORKDIR /srv/jekyll
COPY Gemfile Gemfile.lock /srv/jekyll/
RUN bundler install

COPY . /srv/jekyll
ENV JEKYLL_ENV=production
RUN jekyll build --trace && mv _site /output

FROM nginx:alpine

WORKDIR /usr/share/nginx/html/
COPY --from=build /output .
COPY _nginx/default.conf /etc/nginx/conf.d/
