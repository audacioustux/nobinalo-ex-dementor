defmodule Nobinalo.Seeds do
  @moduledoc """
  Script for populating the database. You can run it as:

    mix run priv/repo/seeds.exs

  Inside the script, you can read and write to any of your
  repositories directly:

    Nobinalo.Repo.insert!(%Nobinalo.SomeSchema{})

  We recommend using the bang functions (`insert!`, `update!`
  and so on) as they will fail if something goes wrong.

  """

  alias Nobinalo.Accounts.Account

  @superusers [%{Account{handle: "audacioustux", password: "audacioustux", ntag: []}]
end
