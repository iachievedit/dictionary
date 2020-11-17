FROM ruby:2.7

RUN apt update
RUN apt install -y bundler
RUN apt install -y nginx


COPY app /apps/dictionary-api
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh

WORKDIR /apps/dictionary-api
RUN bundle install

EXPOSE 80

CMD ["/start.sh"]
