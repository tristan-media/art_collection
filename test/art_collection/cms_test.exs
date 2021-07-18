defmodule ArtCollection.CmsTest do
  use ArtCollection.DataCase

  alias ArtCollection.Cms

  alias ArtCollection.Cms.Nationality

  @valid_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "#paginate_nationalities/1" do
    test "returns paginated list of nationalities" do
      for _ <- 1..20 do
        nationality_fixture()
      end

      {:ok, %{nationalities: nationalities} = page} = Cms.paginate_nationalities(%{})

      assert length(nationalities) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end
  end

  describe "#list_nationalities/0" do
    test "returns all nationalities" do
      nationality = nationality_fixture()
      assert Cms.list_nationalities() == [nationality]
    end
  end

  describe "#get_nationality!/1" do
    test "returns the nationality with given id" do
      nationality = nationality_fixture()
      assert Cms.get_nationality!(nationality.id) == nationality
    end
  end

  describe "#create_nationality/1" do
    test "with valid data creates a nationality" do
      assert {:ok, %Nationality{} = nationality} = Cms.create_nationality(@valid_attrs)
      assert nationality.name == "some name"
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cms.create_nationality(@invalid_attrs)
    end
  end

  describe "#update_nationality/2" do
    test "with valid data updates the nationality" do
      nationality = nationality_fixture()
      assert {:ok, nationality} = Cms.update_nationality(nationality, @update_attrs)
      assert %Nationality{} = nationality
      assert nationality.name == "some updated name"
    end

    test "with invalid data returns error changeset" do
      nationality = nationality_fixture()
      assert {:error, %Ecto.Changeset{}} = Cms.update_nationality(nationality, @invalid_attrs)
      assert nationality == Cms.get_nationality!(nationality.id)
    end
  end

  describe "#delete_nationality/1" do
    test "deletes the nationality" do
      nationality = nationality_fixture()
      assert {:ok, %Nationality{}} = Cms.delete_nationality(nationality)
      assert_raise Ecto.NoResultsError, fn -> Cms.get_nationality!(nationality.id) end
    end
  end

  describe "#change_nationality/1" do
    test "returns a nationality changeset" do
      nationality = nationality_fixture()
      assert %Ecto.Changeset{} = Cms.change_nationality(nationality)
    end
  end

  def nationality_fixture(attrs \\ %{}) do
    {:ok, nationality} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Cms.create_nationality()

    nationality
  end
end
