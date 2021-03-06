FROM  ruby:2.6.3
RUN   apt-get update -qq && \
      apt-get install -y \
      build-essential \
      node.js \
      imagemagick \
      libpq-dev \
      yarn

WORKDIR /circle_app
COPY  Gemfile Gemfile.lock /circle_app/
RUN   bundle install
COPY  . /circle_app
