defmodule ArchiveWeb.DocumentsController do
  use ArchiveWeb, :controller

  def privacy_policy(conn, _params) do
    render(conn, "privacy_policy.html")
  end
end
