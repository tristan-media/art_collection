defmodule ArtCollectionWeb.NationalityControllerTest do
  use ArtCollectionWeb.ConnCase

  alias ArtCollection.Cms

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:nationality) do
    {:ok, nationality} = Cms.create_nationality(@create_attrs)
    nationality
  end

  describe "index" do
    test "lists all nationalities", %{conn: conn} do
      conn = get(conn, Routes.cms_nationality_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Nationalities"
    end
  end

  describe "new nationality" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.cms_nationality_path(conn, :new))
      assert html_response(conn, 200) =~ "New Nationality"
    end
  end

  describe "create nationality" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.cms_nationality_path(conn, :create), nationality: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.cms_nationality_path(conn, :show, id)

      conn = get(conn, Routes.cms_nationality_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Nationality"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.cms_nationality_path(conn, :create), nationality: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Nationality"
    end
  end

  describe "edit nationality" do
    setup [:create_nationality]

    test "renders form for editing chosen nationality", %{conn: conn, nationality: nationality} do
      conn = get(conn, Routes.cms_nationality_path(conn, :edit, nationality))
      assert html_response(conn, 200) =~ "Edit Nationality"
    end
  end

  describe "update nationality" do
    setup [:create_nationality]

    test "redirects when data is valid", %{conn: conn, nationality: nationality} do
      conn =
        put(conn, Routes.cms_nationality_path(conn, :update, nationality),
          nationality: @update_attrs
        )

      assert redirected_to(conn) == Routes.cms_nationality_path(conn, :show, nationality)

      conn = get(conn, Routes.cms_nationality_path(conn, :show, nationality))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, nationality: nationality} do
      conn =
        put(conn, Routes.cms_nationality_path(conn, :update, nationality),
          nationality: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Nationality"
    end
  end

  describe "delete nationality" do
    setup [:create_nationality]

    test "deletes chosen nationality", %{conn: conn, nationality: nationality} do
      conn = delete(conn, Routes.cms_nationality_path(conn, :delete, nationality))
      assert redirected_to(conn) == Routes.cms_nationality_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.cms_nationality_path(conn, :show, nationality))
      end
    end
  end

  defp create_nationality(_) do
    nationality = fixture(:nationality)
    %{nationality: nationality}
  end
end
