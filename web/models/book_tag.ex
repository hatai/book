defmodule BookManagement.BookTag do
  use BookManagement.Web, :model

  schema "book_tags" do
    belongs_to :book, BookManagement.Book
    has_many :tag, BookManagement.Tag

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:book_id, :tag_id])
    |> validate_required([:book_id, :tag_id])
  end
end
