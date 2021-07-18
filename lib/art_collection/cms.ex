defmodule ArtCollection.Cms do
  @moduledoc """
  The Cms context.
  """

  import Ecto.Query, warn: false
  alias ArtCollection.Repo
  import Torch.Helpers, only: [sort: 1, paginate: 4]
  import Filtrex.Type.Config

  alias ArtCollection.Cms.Nationality

  @pagination [page_size: 15]
  @pagination_distance 5

  @doc """
  Paginate the list of nationalities using filtrex
  filters.

  ## Examples

      iex> list_nationalities(%{})
      %{nationalities: [%Nationality{}], ...}
  """
  @spec paginate_nationalities(map) :: {:ok, map} | {:error, any}
  def paginate_nationalities(params \\ %{}) do
    params =
      params
      |> Map.put_new("sort_direction", "desc")
      |> Map.put_new("sort_field", "inserted_at")

    {:ok, sort_direction} = Map.fetch(params, "sort_direction")
    {:ok, sort_field} = Map.fetch(params, "sort_field")

    with {:ok, filter} <-
           Filtrex.parse_params(filter_config(:nationalities), params["nationality"] || %{}),
         %Scrivener.Page{} = page <- do_paginate_nationalities(filter, params) do
      {:ok,
       %{
         nationalities: page.entries,
         page_number: page.page_number,
         page_size: page.page_size,
         total_pages: page.total_pages,
         total_entries: page.total_entries,
         distance: @pagination_distance,
         sort_field: sort_field,
         sort_direction: sort_direction
       }}
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp do_paginate_nationalities(filter, params) do
    Nationality
    |> Filtrex.query(filter)
    |> order_by(^sort(params))
    |> paginate(Repo, params, @pagination)
  end

  @doc """
  Returns the list of nationalities.

  ## Examples

      iex> list_nationalities()
      [%Nationality{}, ...]

  """
  def list_nationalities do
    Repo.all(Nationality)
  end

  @doc """
  Gets a single nationality.

  Raises `Ecto.NoResultsError` if the Nationality does not exist.

  ## Examples

      iex> get_nationality!(123)
      %Nationality{}

      iex> get_nationality!(456)
      ** (Ecto.NoResultsError)

  """
  def get_nationality!(id), do: Repo.get!(Nationality, id)

  @doc """
  Creates a nationality.

  ## Examples

      iex> create_nationality(%{field: value})
      {:ok, %Nationality{}}

      iex> create_nationality(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_nationality(attrs \\ %{}) do
    %Nationality{}
    |> Nationality.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a nationality.

  ## Examples

      iex> update_nationality(nationality, %{field: new_value})
      {:ok, %Nationality{}}

      iex> update_nationality(nationality, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_nationality(%Nationality{} = nationality, attrs) do
    nationality
    |> Nationality.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Nationality.

  ## Examples

      iex> delete_nationality(nationality)
      {:ok, %Nationality{}}

      iex> delete_nationality(nationality)
      {:error, %Ecto.Changeset{}}

  """
  def delete_nationality(%Nationality{} = nationality) do
    Repo.delete(nationality)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking nationality changes.

  ## Examples

      iex> change_nationality(nationality)
      %Ecto.Changeset{source: %Nationality{}}

  """
  def change_nationality(%Nationality{} = nationality, attrs \\ %{}) do
    Nationality.changeset(nationality, attrs)
  end

  defp filter_config(:nationalities) do
    defconfig do
      text(:name)
    end
  end
end
