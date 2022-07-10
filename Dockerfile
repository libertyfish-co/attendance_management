FROM ruby:2.6.5

# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && apt-get install -y nodejs

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# npm自体のバージョンを最新にする
RUN npm install -g npm

# install yarn
RUN npm install -g yarn

RUN mkdir /attendance_management
WORKDIR /attendance_management

COPY Gemfile /attendance_management/Gemfile
COPY Gemfile.lock /attendance_management/Gemfile.lock
RUN bundle install
COPY . /attendance_management
RUN yarn install --check-files
RUN bundle exec rails webpacker:install
RUN bundle exec rails webpacker:compile

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]