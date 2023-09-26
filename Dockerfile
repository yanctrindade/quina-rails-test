FROM ruby:3.2.2-alpine

# Install required dependencies
RUN apk add --no-cache \
    bash \
    build-base \
    nodejs \
    postgresql-dev \
    tzdata \
    gcompat \
    libstdc++ \
    sqlite-libs \
    sqlite-dev

RUN mkdir /project
WORKDIR /project

COPY Gemfile Gemfile.lock ./
RUN gem install bundler --no-document && \
    bundle install --no-binstubs --jobs $(nproc) --retry 3

COPY . .

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
