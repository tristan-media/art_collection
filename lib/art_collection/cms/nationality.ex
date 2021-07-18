defmodule ArtCollection.Cms.Nationality do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nationalities" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(nationality, attrs) do
    nationality
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
