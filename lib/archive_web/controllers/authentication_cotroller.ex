defmodule ArchiveWeb.AuthenticationController do
  import Plug.Conn
  import Phoenix.Controller

  alias Archive.Accounts
  alias ArchiveWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    IO.puts "user_id get_session"
    IO.inspect user_id
    user = user_id && Accounts.get_user(user_id)

    IO.inspect user
    assign(conn, :current_user, user)
  end

  def authenticate_user(conn, _opts) do
    IO.puts "authentificating user"
    if conn.assigns.current_user do
      IO.puts "we have a current user"
      conn
    else
      IO.puts "no current user"
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.home_path(conn, :index))
      |> halt()
    end
  end

  def sign_in(conn, user) do
    conn
    |> put_current_user(user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def sign_out(conn) do
    #Guardian.Plug.sign_out(conn)
  end

  defp put_current_user(conn, user) do
    token = Phoenix.Token.sign(conn, "user socket", user.id)

    conn
    |> assign(:current_user, user)
    |> assign(:user_token, token)
  end
end
