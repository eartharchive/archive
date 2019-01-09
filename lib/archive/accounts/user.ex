defmodule Archive.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Archive.Accounts.Credential


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :email, :string, virtual: true
    has_one :credential, Credential

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username, :email, :password, :password_confirmation])
    |> validate_required([:name, :email, :password, :password_confirmation])
    |> unique_constraint(:email)
    |> validate_confirmation(:password)
  end
end
