defmodule BookManagement.Ldap do
@moduledoc """
LDAP 認証を行うためのモジュール
"""

  @doc """
  LDAP 認証を行う
  """
  def authenticate(uid, password) do
    {:ok, ldap_conn} = Exldap.open
    bind = "UID=#{uid},DC=network21,DC=local"

    case Exldap.verify_credentials(ldap_conn, bind, password) do
      :ok -> :ok
      _ -> {
        :error, "Invalid username / password"
      }
    end
  end
  
  @doc """
  UID をもとにユーザーを見つける
  """
  def get_by_uid(uid) do
    {:ok, ldap_conn} = Exldap.connect
    {:ok, search_results} = Exldap.search_field(ldap_conn, "uid", uid)

    case search_results do
      [] -> {
        :error, "Could not find user with uid #{uid}"
      }
      _ -> search_results |> Enum.fetch
    end
  end

  @doc """
  ユーザー情報を取得し、Map に整形して返す
  """
  def to_map(entry) do
    username = Exldap.search_attributes(entry, "uid")
    name = Exldap.search_attributes(entry, "CN")
    email = Exldap.search_attributes(entry, "mail")
    %{usernam: username, name: name, email: email}
  end
end
