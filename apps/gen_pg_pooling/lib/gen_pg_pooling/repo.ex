defmodule GenPgPooling.Repo do
  use Ecto.Repo,
    otp_app: :gen_pg_pooling,
    adapter: Ecto.Adapters.Postgres
end
