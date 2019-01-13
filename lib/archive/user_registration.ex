defmodule Archive.UserRegistration do
  alias Ecto.Multi
  alias Archive.{Accounts, Archives}

  def register_user(params) do
    Multi.new()
    |> Multi.run(:user, fn _ -> Accounts.create_user(params) end)
    |> Multi.run(:author, fn %{user: user} ->
      {:ok, Archives.ensure_author_exists(user)}
    end)
    |> Repo.transaction()
  end
end
