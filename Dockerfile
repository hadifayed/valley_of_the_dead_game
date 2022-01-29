FROM ruby:3-alpine
WORKDIR /app
ADD ./Gemfile /app/Gemfile
RUN bundle install;
