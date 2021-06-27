defmodule ArtCollection.Repo do
  use Ecto.Repo,
    otp_app: :art_collection,
    adapter: Ecto.Adapters.Postgres
end
