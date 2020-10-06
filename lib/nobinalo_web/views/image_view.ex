defmodule NobinaloWeb.ImageView do
  use NobinaloWeb, :view
  alias NobinaloWeb.ImageView

  def render("index.json", %{images: images}) do
    %{data: render_many(images, ImageView, "image.json")}
  end

  def render("show.json", %{image: image}) do
    %{data: render_one(image, ImageView, "image.json")}
  end

  def render("image.json", %{image: image}) do
    %{
      id: image.id,
      name: image.name,
      width: image.width,
      height: image.height,
      size: image.size,
      mime: image.mime,
      varient: image.varient
    }
  end
end
