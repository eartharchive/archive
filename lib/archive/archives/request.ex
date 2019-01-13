defmodule Archive.Archives.Request do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "requests" do
    field :content, :string
    field :status, :string
    field :title, :string
    belongs_to :partner, Archive.Archives.Partner

    timestamps()
  end

  @doc false
  def changeset(request, attrs) do
    request
    |> cast(attrs, [:title, :content, :status])
    |> validate_required([:title, :content])
  end
end
