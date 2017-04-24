defmodule BookManagement.LendingManagementsTest do
  use BookManagement.ModelCase

  alias BookManagement.LendingManagements

  @valid_attrs %{expected_return_date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, lending_date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, return_date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, returned_flag: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = LendingManagements.changeset(%LendingManagements{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = LendingManagements.changeset(%LendingManagements{}, @invalid_attrs)
    refute changeset.valid?
  end
end
