defmodule LLAdmin.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :title, :string, null: false
      add :slug, :string, null: false
      add :content, :string, default: "", null: false

      timestamps()
    end

    create unique_index(:pages, [:slug])
  end
end
