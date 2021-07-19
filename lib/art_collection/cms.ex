defmodule ArtCollection.Cms do
  @moduledoc """
  The Cms context.
  """

  import Ecto.Query, warn: false
  alias ArtCollection.Repo

  alias ArtCollection.Cms.Nationality

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
  Deletes a nationality.

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
      %Ecto.Changeset{data: %Nationality{}}

  """
  def change_nationality(%Nationality{} = nationality, attrs \\ %{}) do
    Nationality.changeset(nationality, attrs)
  end
end
