defmodule ArtCollectionWeb.NationalityController do
  use ArtCollectionWeb, :controller

  alias ArtCollection.Cms
  alias ArtCollection.Cms.Nationality

  def index(conn, _params) do
    nationalities = Cms.list_nationalities()
    render(conn, "index.html", nationalities: nationalities)
  end

  def new(conn, _params) do
    changeset = Cms.change_nationality(%Nationality{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"nationality" => nationality_params}) do
    case Cms.create_nationality(nationality_params) do
      {:ok, nationality} ->
        conn
        |> put_flash(:info, "Nationality created successfully.")
        |> redirect(to: Routes.cms_nationality_path(conn, :show, nationality))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    nationality = Cms.get_nationality!(id)
    render(conn, "show.html", nationality: nationality)
  end

  def edit(conn, %{"id" => id}) do
    nationality = Cms.get_nationality!(id)
    changeset = Cms.change_nationality(nationality)
    render(conn, "edit.html", nationality: nationality, changeset: changeset)
  end

  def update(conn, %{"id" => id, "nationality" => nationality_params}) do
    nationality = Cms.get_nationality!(id)

    case Cms.update_nationality(nationality, nationality_params) do
      {:ok, nationality} ->
        conn
        |> put_flash(:info, "Nationality updated successfully.")
        |> redirect(to: Routes.cms_nationality_path(conn, :show, nationality))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", nationality: nationality, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    nationality = Cms.get_nationality!(id)
    {:ok, _nationality} = Cms.delete_nationality(nationality)

    conn
    |> put_flash(:info, "Nationality deleted successfully.")
    |> redirect(to: Routes.cms_nationality_path(conn, :index))
  end
end
