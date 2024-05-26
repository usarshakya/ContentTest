FROM ruby:3.3.1-alpine3.19

RUN apk update alpine-sdk && \
    apk add --no-cache \
        build-base \
        tzdata \
        libffi-dev \
        libpq-dev \
        gcompat 

# Set working directory
WORKDIR /opt/content_test_api

# Install Bundler
RUN gem install bundler

# Copy Gemfile and Gemfile.lock
COPY Gemfile* ./

# Install gems
RUN bundle install

# Copy application code
COPY . .

# Expose port
ARG DEFAULT_PORT=3000
EXPOSE ${DEFAULT_PORT}

# Run start script
CMD /bin/sh start.sh
