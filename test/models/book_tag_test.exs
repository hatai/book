defmodule BookManagement.BookTagTest do
  use BookManagement.ModelCase

  alias BookManagement.BookTag

  @valid_attrs %{book_id: 42, tag_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = BookTag.changeset(%BookTag{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = BookTag.changeset(%BookTag{}, @invalid_attrs)
    refute changeset.valid?
  end
end
