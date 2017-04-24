defmodule BookManagement.Repo.Migrations.AlterBookTable do
  use Ecto.Migration

  def change do
    alter table(:books) do
      modify :published, :date
      add :purchase_date, :date
    end

    alter table(:lending_managements) do
      modify :lending_date, :date
      modify :return_date, :date
      modify :expected_return_date, :date
    end
  end
end
