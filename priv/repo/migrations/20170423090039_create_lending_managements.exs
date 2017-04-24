defmodule BookManagement.Repo.Migrations.CreateLendingManagements do
  use Ecto.Migration

  def change do
    create table(:lending_managements) do
      add :lending_date, :datetime
      add :return_date, :datetime
      add :expected_return_date, :datetime
      add :returned_flag, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :book_id, references(:books, on_delete: :nothing)

      timestamps()
    end
    create index(:lending_managements, [:user_id])
    create index(:lending_managements, [:book_id])

  end
end
