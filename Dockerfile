# http://docs.docker.jp/engine/reference/builder.html
FROM ubuntu:xenial

MAINTAINER Taigen Hamada <t.hamada@nt21.jp>

WORKDIR /app

# Elixir requires UTF-8
ENV LANG C.UTF-8
ENV PORT=8000

RUN apt update \
  && apt upgrade -y \
  && apt install -y curl wget git make sudo \
  && deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main \
  && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - \
  && curl http://nginx.org/keys/nginx_signing.key | sudo apt-key add - \
  && sh -c "echo 'deb http://nginx.org/packages/ubuntu/ xenial nginx' >> /etc/apt/sources.list" \
  && sh -c "echo 'deb-src http://nginx.org/packages/ubuntu/ xenial nginx' >> /etc/apt/sources.list" \
  && wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
  && dpkg -i erlang-solutions_1.0_all.deb \
  && apt update \
  && rm erlang-solutions_1.0_all.deb

RUN apt install -y build-essential nodejs nginx postgresql-9.6 \
  && apt install -y esl-erlang elixir erlang-dev erlang-dialyzer erlang-parsetools \
  && apt autoremove -y \
  && apt clean 

RUN mix local.hex \
  && mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

# TODO:
COPY

# TODO:
ONBUILD COPY
ONBUILD RUN

EXPOSE PORT

CMD ["/bin/my_app","start"]
