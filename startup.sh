#! /usr/env/bash

ERLANG_VERSION=20.0
ELIXIR_VERSION=1.4.5
NODEJS_VERSION=6.11.0
POSTGRES_VERSION=9.6

# install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.3.0 && \
echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc && \
echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc && \
source ~/.bashrc
sudo apt-get -y install build-essential autoconf m4 libncurses5-dev libwxgtk3.0-dev libgl1-mesa-dev libglu1-mesa-dev libssh-dev unixodbc-dev
# install erlang
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf install erlang $ERLANG_VERSION
asdf global erlang $ERLANG_VERSION
# install elixir
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf isntall elixir $ELIXIR_VERSION
asdf global elixir $ELIXIR_VERSION
# install nodejs
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
# Imports Node.js release team's OpenPGP keys to main keyring
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install nodejs $NODEJS_VERSION
asdf global nodejs $NODEJS_VERSION
# install yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
# install hex
mix local.hex
# install phoenix
mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
# isntall PostgreSQL
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
sudo apt-key add -
sudo apt update && sudo apt install postgresql-$POSTGRES_VERSION
