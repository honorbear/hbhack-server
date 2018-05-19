FROM ruby:2.5.1

MAINTAINER Li-Yun Chang <michael142536@gmail.com>

ENV LANG="C.UTF-8" INSTALL_PATH="/usr/src/hbhack/"

RUN set -ex; \
    apt-get update; \
    apt-get install -qq -y --no-install-recommends apt-transport-https unzip; \
    curl -sL https://github.com/adobe-fonts/source-han-sans/raw/release/SubsetOTF/SourceHanSansTW.zip > /tmp/SourceHanSansTW.zip; \
    mkdir -p /usr/share/fonts/opentype; \
    unzip /tmp/SourceHanSansTW.zip -d /usr/share/fonts/opentype; \
    fc-cache -f -v; \
    curl -sL https://deb.nodesource.com/setup_8.x | bash -; \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -; \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list; \
    apt-get update; \
    apt-get install -qq -y --no-install-recommends \
      build-essential \
      nodejs \
      git \
      libmagick++-dev \
      ttf-wqy-zenhei \
      yarn; \
    rm -rf /tmp/* /var/lib/apt/lists/*

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock $INSTALL_PATH

RUN bundle install

COPY package.json yarn.lock $INSTALL_PATH

RUN yarn install

COPY . $INSTALL_PATH
