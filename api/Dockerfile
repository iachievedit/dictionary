FROM ruby:2.7

RUN apt update
RUN apt install -y bundler

WORKDIR /opt/iachievedit/apps/dictionary-api
COPY .  /opt/iachievedit/apps/dictionary-api

RUN bundle install

EXPOSE 9000

CMD bundle exec rackup --host 0.0.0.0 -p 9000
