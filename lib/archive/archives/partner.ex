defmodule Archive.Archives.Partner do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "partners" do
    field :role, :string
    has_many :requests, Archive.Archives.Request
    belongs_to :user, Archive.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(partner, attrs) do
    partner
    |> cast(attrs, [:role])
    |> validate_required([:role])
    |> unique_constraint(:user_id)
  end
end
