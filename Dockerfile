FROM  ruby:2.6.3
RUN   apt-get update -qq && \
      apt-get install -y \
      build-essential \
      node.js \
      imagemagick \
      libpq-dev \
      yarn

RUN   sh -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
      sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
      apt-get update && apt-get install -y google-chrome-stable

WORKDIR /circle_app
COPY  Gemfile Gemfile.lock /circle_app/
RUN   bundle install
COPY  . /circle_app
