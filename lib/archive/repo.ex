defmodule Archive.Repo do
  use Ecto.Repo,
    otp_app: :archive,
    adapter: Ecto.Adapters.Postgres
end
