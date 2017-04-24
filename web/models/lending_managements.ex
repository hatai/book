defmodule BookManagement.LendingManagements do
  use BookManagement.Web, :model

  schema "lending_managements" do
    field :lending_date, Ecto.Date
    field :return_date, Ecto.Date
    field :expected_return_date, Ecto.Date
    field :returned_flag, :integer
    belongs_to :user, BookManagement.User
    has_many :book, BookManagement.Book

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:lending_date, :return_date, :expected_return_date, :returned_flag])
    |> validate_required([:lending_date, :return_date, :expected_return_date, :returned_flag])
  end
end
