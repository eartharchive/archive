defmodule Archive.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :content, :text
      add :status, :string
      add :partner_id, references(:partners, on_delete: :nothing, type: :binary_id, null: false)

      timestamps()
    end

    create index(:requests, [:partner_id])

  end
end
