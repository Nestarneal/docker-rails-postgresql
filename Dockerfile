FROM ruby:3.0.0

RUN \
    curl https://deb.nodesource.com/setup_12.x | bash && \
    curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y nodejs yarn postgresql-client

WORKDIR /app
COPY Gemfile Gemfile.lock package.json yarn.lock ./
RUN bundle install && yarn install
COPY . ./

EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
