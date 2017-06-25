# BookManagement

## Enviroment

* Ubuntu: 17.04
* Erlang: 20.0
* Elixir: 1.4.5
* PostgreSQL: 20.0
* Node.js: 6.11.0
* Phoenix: 1.2.3

## Install asdf, Elixir and Erlang

```bash
# install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.3.0
echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
source ~/.bashrc
sudo apt-get -y install build-essential autoconf m4 libncurses5-dev libwxgtk3.0-dev libgl1-mesa-dev libglu1-mesa-dev libssh-dev unixodbc-dev
# install erlang
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf install erlang 20.0
asdf global erlang 20.0
# install elixir
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf isntall elixir 1.4.5
asdf global elixir 1.4.5
# install nodejs
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
# Imports Node.js release team's OpenPGP keys to main keyring
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install nodejs 6.11.0
asdf global nodejs 6.11.0
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
sudo apt update && sudo apt install postgresql-9.6
```

## Setup

To start your Phoenix app:

* Create PostgreSQL user with `sudo -u postgres createuser -P -s -e phoenix`
* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.create && mix ecto.migrate`
* Install Node.js dependencies with `yarn install`
* Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

* Official website: http://www.phoenixframework.org/
* Guides: http://phoenixframework.org/docs/overview
* Docs: https://hexdocs.pm/phoenix
* Mailing list: http://groups.google.com/group/phoenix-talk
* Source: https://github.com/phoenixframework/phoenix
