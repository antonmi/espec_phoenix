defmodule Rumbl.Repo do
  use Ecto.Repo, otp_app: :rumbl,
  adapter: Ecto.Adapters.Postgres

end
