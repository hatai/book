defmodule BookManagement.Repo.Migrations.ChangeBookTagsTable do
  use Ecto.Migration

  def change do
    alter table(:book_tags) do
      modify :book_id, references(:books, on_delete: :nothing)
      modify :tag_id, references(:tags, on_delete: :nothing)
    end
    create index(:book_tags, [:book_id])
    create index(:book_tags, [:tag_id])
  end
end
