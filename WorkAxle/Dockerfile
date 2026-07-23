FROM ruby:3.4.4

ARG API_BASE_URL

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock /usr/src/app/
RUN bundle install

COPY . /usr/src/app

EXPOSE 9292

CMD [ "bundle", "exec", "rackup", "-o", "0.0.0.0" ]