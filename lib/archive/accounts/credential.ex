defmodule Archive.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias Archive.Accounts.Credential
  alias Archive.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "credentials" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :provider, :string
    field :uid, :string
    field :verified, :boolean, default: false
    field :is_new?, :boolean, virtual: true
    belongs_to :user, Archive.Accounts.User

    timestamps()
  end

  @oauth2_fields ~w(email provider uid is_new?)a
  @identity_fields ~w(email password is_new?)a

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email, :password_hash, :provider, :uid, :verified])
    |> validate_required([:email, :password_hash, :provider, :uid, :verified])
    |> unique_constraint(:email)
  end

  def oauth2_changeset(%Credential{} = auth, params) do
    auth
    |> cast(params, @oauth2_fields)
    |> validate_required(@oauth2_fields)
    |> unique_constraint(:email)
    |> IO.inspect()
    |> cast_assoc(:partner, required: true, with: &user_changeset/2)
  end

  def identity_changeset(%Credential{} = auth, params) do
    IO.inspect auth
    IO.inspect params
    auth
    |> cast(params, @identity_fields)
    |> validate_required(@identity_fields)
    |> unique_constraint(:email)
    |> validate_confirmation(:password)
    |> put_password_hash()
    |> cast_assoc(:user, required: true, with: &user_changeset/2)
  end

  defp user_changeset(user, attrs) do
    User.changeset(user, attrs)
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))

      _ ->
        changeset
    end
  end
end
