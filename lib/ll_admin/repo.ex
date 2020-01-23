defmodule LLAdmin.Repo do
  use Ecto.Repo,
    otp_app: :ll_admin,
    adapter: Ecto.Adapters.Postgres
end
