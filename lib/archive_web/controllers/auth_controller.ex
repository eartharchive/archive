defmodule ArchiveWeb.AuthController do
  use ArchiveWeb, :controller

  alias Archive.Accounts

  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn), layout: false)
  end

  def delete(conn) do
    IO.puts "delete auth"
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def delete(conn, _params) do
    IO.puts "delete with params"
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authentificate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Accounts.authentificate_by_oauth2(auth) do
      {:ok, authentication} ->
        conn
        |> put_flash(:info, "Successfully authentificated. #{authentication.email} #{authentication.provider}")
        |> Accounts.sign_in(authentication)
        # |> redirect(to: Routes.dashboard_path(conn, :index))
        |> redirect(to: "/")
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Failed to authenticate")
        #|> render("error.html")
        |> redirect(to: "/")
    end
  end

  def identity_callback(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate_by_email_and_password(email, password) do
      {:ok, auth} ->
        conn
        |> put_flash(:info, "Successfully authentificated. #{auth.email}")
        |> Accounts.sign_in(auth.user)
        |> redirect(to: "/")
        # |> redirect(to: Routes.home_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Failed to authenticate")
        #|> render("error.html")
        |> redirect(to: "/")
    end
  end

  def logout(conn, _) do
    conn
    |> Accounts.sign_out()
    |> redirect(to: "/")
  end
end
