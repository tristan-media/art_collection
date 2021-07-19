defmodule ArtCollection.CmsTest do
  use ArtCollection.DataCase

  alias ArtCollection.Cms

  describe "nationalities" do
    alias ArtCollection.Cms.Nationality

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def nationality_fixture(attrs \\ %{}) do
      {:ok, nationality} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cms.create_nationality()

      nationality
    end

    test "list_nationalities/0 returns all nationalities" do
      nationality = nationality_fixture()
      assert Cms.list_nationalities() == [nationality]
    end

    test "get_nationality!/1 returns the nationality with given id" do
      nationality = nationality_fixture()
      assert Cms.get_nationality!(nationality.id) == nationality
    end

    test "create_nationality/1 with valid data creates a nationality" do
      assert {:ok, %Nationality{} = nationality} = Cms.create_nationality(@valid_attrs)
      assert nationality.name == "some name"
    end

    test "create_nationality/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cms.create_nationality(@invalid_attrs)
    end

    test "update_nationality/2 with valid data updates the nationality" do
      nationality = nationality_fixture()

      assert {:ok, %Nationality{} = nationality} =
               Cms.update_nationality(nationality, @update_attrs)

      assert nationality.name == "some updated name"
    end

    test "update_nationality/2 with invalid data returns error changeset" do
      nationality = nationality_fixture()
      assert {:error, %Ecto.Changeset{}} = Cms.update_nationality(nationality, @invalid_attrs)
      assert nationality == Cms.get_nationality!(nationality.id)
    end

    test "delete_nationality/1 deletes the nationality" do
      nationality = nationality_fixture()
      assert {:ok, %Nationality{}} = Cms.delete_nationality(nationality)
      assert_raise Ecto.NoResultsError, fn -> Cms.get_nationality!(nationality.id) end
    end

    test "change_nationality/1 returns a nationality changeset" do
      nationality = nationality_fixture()
      assert %Ecto.Changeset{} = Cms.change_nationality(nationality)
    end
  end
end
