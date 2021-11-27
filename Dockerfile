FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y postgresql-client chromium-driver build-essential libxslt-dev libxml2-dev cmake
RUN mkdir /app
WORKDIR /app

# install nodejs
RUN apt-get install -y nodejs npm
RUN npm install n -g 
RUN n 14.15.0

# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler:2.1.4
RUN bundle install
RUN yarn install
COPY . /app
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]