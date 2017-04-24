defmodule BookManagement.BookTest do
  use BookManagement.ModelCase

  alias BookManagement.Book

  @valid_attrs %{isbn_10: "some content", isbn_13: "some content", name: "some content", number: 42, page: 42, price: 42, published: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, publisher: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Book.changeset(%Book{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Book.changeset(%Book{}, @invalid_attrs)
    refute changeset.valid?
  end
end
