# http://docs.docker.jp/engine/reference/builder.html
FROM ubuntu:xenial

MAINTAINER Taigen Hamada <t.hamada@nt21.jp>

WORKDIR /app

# Elixir requires UTF-8
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN echo 'Acquire::http::Pipeline-Depth "0";' >> /etc/apt/apt.conf.d/00no-pipeline \
  && apt-get update \
  && apt-get install -y --no-install-recommends apt-utils \
  && apt-get install -y curl wget git make sudo apt-file \
  && apt-get upgrade -y \
  && apt-file update \
  && apt-file search add-apt-repository \
  && apt-get install -y software-properties-common

RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add - \
  && add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" \
  && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - \
  && sh -c "echo 'deb http://nginx.org/packages/ubuntu/ xenial nginx' >> /etc/apt/sources.list" \
  && sh -c "echo 'deb-src http://nginx.org/packages/ubuntu/ xenial nginx' >> /etc/apt/sources.list" \
  && wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
  && dpkg -i erlang-solutions_1.0_all.deb \
  && apt-get update \
  && rm erlang-solutions_1.0_all.deb \
  && apt-get install -y build-essential nodejs nginx postgresql-9.6 \
  && apt-get install -y esl-erlang elixir \
  && apt-get autoremove -y \
  && apt-get clean

RUN mix local.hex \
  && mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

# TODO:
#COPY

# TODO:
#ONBUILD COPY

# Initial setup
#ONBUILD RUN mix deps.get --only prod \
#  && MIX_ENV=prod mix compile \
  # Compile assets
#  && burunch build --production \
#  && MIX_ENV=prod mix phoenix.digest \
  # Custom task
#  && MIX_ENV=prod mix ecto.create \
#  && MIX_ENV=prod mix ecto.migrate \
  # Finaly run the server
#  && PORT=4001 MIX_ENV=prod mix phoenix.server


EXPOSE 4000

CMD ["/bin/bash"]
