use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :book_management, BookManagement.Endpoint,
  secret_key_base: "6Uf6VA1/tgGnCc4hQxPeDej5/SN4P5iWcOtCY7MdKvTIZDO/mivIFgUYwbOgC9Wd"

# Configure your database
config :book_management, BookManagement.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "book_management_prod",
  pool_size: 20
