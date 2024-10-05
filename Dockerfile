FROM ruby:2.5.1

WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN bundle install

COPY . /app

EXPOSE 3000

CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails s -b '0.0.0.0'"]
