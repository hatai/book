defmodule BookManagement.Repo.Migrations.AddAutherBookTable do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :auther, :string
    end
    create index(:books, [:auther])
    create index(:books, [:name])
  end
end
