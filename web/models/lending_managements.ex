defmodule BookManagement.LendingManagements do
  use BookManagement.Web, :model

  schema "lending_managements" do
    # 貸出日
    field :lending_date, Ecto.Date
    # 返却日
    field :return_date, Ecto.Date
    # 返却予定日
    field :expected_return_date, Ecto.Date
    # 返却フラグ
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
    |> cast(params, 
      [
        :lending_date,
        :return_date,
        :expected_return_date,
        :returned_flag
      ]
    )
    |> validate_required(
      [
        :lending_date,
        :return_date,
        :expected_return_date,
        :returned_flag
      ]
    )
  end
end
