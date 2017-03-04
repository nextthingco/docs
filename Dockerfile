FROM ubuntu:16.04

ADD Gemfile Gemfile

RUN apt-get update && apt-get install -yq ruby ruby ruby-dev pkg-config build-essential nodejs git libxml2-dev libxslt-dev libz-dev zip python-pip npm wget
RUN ln -s `which nodejs` /usr/bin/node
RUN gem install bundler
RUN pip install awscli
RUN npm install --global surge
RUN bundle install
