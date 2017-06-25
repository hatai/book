defmodule BookManagement.Book do
  use BookManagement.Web, :model

  schema "books" do
    # 書籍名
    field :name, :string
    # 値段
    field :price, :integer
    # 出版日
    field :published, Ecto.Date
    # 総ページ数
    field :page, :integer
    # ISBN10 コード
    field :isbn_10, :string
    # ISBN13 コード
    field :isbn_13, :string
    # 著者
    field :auther, :string
    # 出版社
    field :publisher, :string
    # 蔵書数
    field :number, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, 
      [
        :name,
        :price,
        :published,
        :page,
        :isbn_10,
        :isbn_13,
        :publisher,
        :number
      ]
    )
    |> validate_required([
      :name,
      :price,
      :published,
      :page,
      :isbn_10,
      :isbn_13,
      :publisher,
      :number
    ])
  end
end
