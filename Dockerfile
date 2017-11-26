FROM ruby:2.4.2-stretch
COPY . /usr/src/app/
WORKDIR /usr/src/app/
RUN bundle install
RUN bundle exec sidekiq
RUN bundle exec rails server -p 3001