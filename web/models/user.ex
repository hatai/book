defmodule BookManagement.User do
  use BookManagement.Web, :model

  schema "users" do
    field :username, :string
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :name, :email])
    |> validate_required([:username, :name, :email])
  end

  def login_changeset(struct, params \\ %{}) do
    struct 
    |> cast(params, [:username, :password])
    |> validate_required([:username, :password])
  end
end
