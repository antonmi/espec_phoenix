defmodule Eph.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
  	create table :posts do
      add :title, :string
      add :text, :text
    end
  end
end
