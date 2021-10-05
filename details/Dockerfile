FROM ruby:3.0.2-slim-buster

WORKDIR /usr/src/app

COPY . .
RUN gem install webrick

CMD ["ruby", "details.rb", "9080"]
