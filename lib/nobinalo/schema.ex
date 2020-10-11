defmodule Nobinalo.Schema do
  @moduledoc """
  modified Ecto.Schema for extensibility
  e.g: changing the default timestamp type
  """
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @timestamps_opts [type: :utc_datetime_usec]
    end
  end
end
