defmodule BookManagement.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :name, :string
      add :price, :integer
      add :published, :datetime
      add :page, :integer
      add :isbn_10, :string
      add :isbn_13, :string
      add :publisher, :string
      add :number, :integer

      timestamps()
    end

  end
end
