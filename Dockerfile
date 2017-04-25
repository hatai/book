# http://docs.docker.jp/engine/reference/builder.html
FROM ubuntu:xenial

MAINTAINER Taigen Hamada <t.hamada@nt21.jp>

WORKDIR /app

# Elixir requires UTF-8
ENV LANG C.UTF-8
ENV PORT=4000

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y curl wget git make sudo apt-file \
  && apt-file update \
  && apt-file search add-apt-repository \
  && apt-get install -y software-properties-common \
  && curl http://nginx.org/keys/nginx_signing.key | sudo apt-key add - \
  && add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" \
  && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - \
  && sh -c "echo 'deb http://nginx.org/packages/ubuntu/ xenial nginx' >> /etc/apt/sources.list" \
  && sh -c "echo 'deb-src http://nginx.org/packages/ubuntu/ xenial nginx' >> /etc/apt/sources.list" \
  && wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
  && dpkg -i erlang-solutions_1.0_all.deb \
  && apt-get update \
  && rm erlang-solutions_1.0_all.deb

RUN apt-get install -y build-essential nodejs nginx postgresql-9.6 \
  && apt-get install -y esl-erlang elixir \
  && apt-get autoremove -y \
  && apt-get clean

RUN mix local.hex \
  && mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

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


EXPOSE PORT

CMD ["/bin/bash"]
