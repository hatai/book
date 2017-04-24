defmodule BookManagement.Book do
  use BookManagement.Web, :model

  schema "books" do
    field :name, :string
    field :price, :integer
    field :published, Ecto.Date
    field :page, :integer
    field :isbn_10, :string
    field :isbn_13, :string
    field :publisher, :string
    field :number, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :price, :published, :page, :isbn_10, :isbn_13, :publisher, :number])
    |> validate_required([:name, :price, :published, :page, :isbn_10, :isbn_13, :publisher, :number])
  end
end
