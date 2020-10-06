defmodule NobinaloWeb.ImageControllerTest do
  use NobinaloWeb.ConnCase

  alias Nobinalo.Files.Images
  alias Nobinalo.Files.Images.Image

  @create_attrs %{
    height: 42,
    mime: "some mime",
    name: "some name",
    size: 42,
    varient: "some varient",
    width: 42
  }
  @update_attrs %{
    height: 43,
    mime: "some updated mime",
    name: "some updated name",
    size: 43,
    varient: "some updated varient",
    width: 43
  }
  @invalid_attrs %{
    height: nil,
    mime: nil,
    name: nil,
    size: nil,
    varient: nil,
    width: nil
  }

  def fixture(:image) do
    {:ok, image} = Images.create_image(@create_attrs)
    image
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all images", %{conn: conn} do
      conn = get(conn, Routes.image_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create image" do
    test "renders image when data is valid", %{conn: conn} do
      conn = post(conn, Routes.image_path(conn, :create), image: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.image_path(conn, :show, id))

      assert %{
               "id" => id,
               "height" => 42,
               "mime" => "some mime",
               "name" => "some name",
               "size" => 42,
               "varient" => "some varient",
               "width" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.image_path(conn, :create), image: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update image" do
    setup [:create_image]

    test "renders image when data is valid", %{
      conn: conn,
      image: %Image{id: id} = image
    } do
      conn =
        put(conn, Routes.image_path(conn, :update, image), image: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.image_path(conn, :show, id))

      assert %{
               "id" => id,
               "height" => 43,
               "mime" => "some updated mime",
               "name" => "some updated name",
               "size" => 43,
               "varient" => "some updated varient",
               "width" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, image: image} do
      conn =
        put(conn, Routes.image_path(conn, :update, image), image: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete image" do
    setup [:create_image]

    test "deletes chosen image", %{conn: conn, image: image} do
      conn = delete(conn, Routes.image_path(conn, :delete, image))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.image_path(conn, :show, image))
      end
    end
  end

  defp create_image(_) do
    image = fixture(:image)
    %{image: image}
  end
end
