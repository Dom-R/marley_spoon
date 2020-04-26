FROM ruby:2.7.0

WORKDIR /marley_spoon

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle config set without 'test development' && bundle install

COPY . .

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]
