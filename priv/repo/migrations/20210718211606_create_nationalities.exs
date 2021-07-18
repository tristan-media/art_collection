defmodule ArtCollection.Repo.Migrations.CreateNationalities do
  use Ecto.Migration

  def change do
    create table(:nationalities) do
      add :name, :string

      timestamps()
    end
  end
end
