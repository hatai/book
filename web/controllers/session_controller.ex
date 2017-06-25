defmodule BookManagement.SessionController do
  use BookManagement.Web, :controller
  alias BookManagement.{User, Repo, Ldap}

  @doc """
  new.html をレンダリングする
  """
  def new(conn, params) do
    render conn, "new.html", changeset: User.login_changeset %User{}, params
  end

  @doc """
  username, password をもとに LDAP モジュールを用いて認証する
  """
  def create(conn, %{"user" => params}) do
    username = params["username"]
    password = params["password"]

    # LDAP 認証を行う
    case Ldap.authenticate(username, password) do
      :ok -> handle_sign_in(conn, username)
      _ -> handle_error(conn)
    end
  end

  @doc """
  ログアウト処理
  """
  def delete(conn, _params) do
    Guardian.Plug.sign_out(conn)
    |> put_flash(:info, "Logged out seccessfully")
    |> redirect(to: "/")
  end

  defp handle_sign_in(conn, username) do
    # LDAP 認証が成功した場合に、ユーザ情報をDBに保存する
    {:ok, user} = insert_or_update_user(username)

    conn
    |> put_flash(:info, "Logged in")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: page_path(conn, :index))
  end

  defp insert_or_update_user(username) do
    # ユーザー情報を、新規登録または更新する
    {:ok, ldap_entry} = Ldap.get_by_uid(username)
    user_attributes = Ldap.to_map(ldap_entry)
    user = Repo.get_by(User, username: username)
  
    changeset = 
      case user do
        nil -> User.changeset(%User{}, user_attributes)
        _ -> User.changeset(user, user_attributes)
      end

    Repo.insert_or_update changeset
  end

  defp handle_error(conn) do
    # エラーメッセージを表示する
    conn
    |> put_flash(:error, "Wrong username or password")
    |> redirect(to: session_path(conn, :new))
  end
end