FROM ruby:3.0.0-alpine

WORKDIR /app

RUN apk --no-cache add build-base

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4

COPY . .

CMD ["rake", "telegram:bot:start"]
