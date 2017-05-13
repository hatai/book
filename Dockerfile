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
  && apt-file update \
  && apt-file search add-apt-repository \
  && apt-get install -y software-properties-common

RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add - \
  && add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" \
  && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && sh -c "echo 'deb http://nginx.org/packages/ubuntu/ xenial nginx' >> /etc/apt/sources.list" \
  && sh -c "echo 'deb-src http://nginx.org/packages/ubuntu/ xenial nginx' >> /etc/apt/sources.list" \
  && wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
  && dpkg -i erlang-solutions_1.0_all.deb \
  && apt-get update \
  && rm erlang-solutions_1.0_all.deb \
  && apt-get install -y build-essential nginx postgresql-9.6 \
  && apt-get install -y esl-erlang elixir \
  && apt-get autoremove -y \
  && apt-get clean

RUN groupadd --gid 1000 node \
    && useradd --uid 1000 --gid node --shell /bin/bash --create-home node

  # gpg keys listed at https://github.com/nodejs/node#release-team
RUN set -ex \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B 94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E 71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 56730D5401028683275BD23C23EFEFE93C4CFFFE \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
    gpg --keyserver keyserver.pgp.com --recv-keys "$key" ; \
    done

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 6.10.3

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-x64.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs

ENV YARN_VERSION 0.23.4

RUN set -ex && for key in \
    6A010C5166006599AA17F08146C2130DFD2497F5 \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
    gpg --keyserver keyserver.pgp.com --recv-keys "$key" ; \
  done \
  && curl -fSL -o yarn.js "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-legacy-$YARN_VERSION.js" \
  && curl -fSL -o yarn.js.asc "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-legacy-$YARN_VERSION.js.asc" \
  && gpg --batch --verify yarn.js.asc yarn.js \
  && rm yarn.js.asc \
  && mv yarn.js /usr/local/bin/yarn \
  && chmod +x /usr/local/bin/yarn

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
