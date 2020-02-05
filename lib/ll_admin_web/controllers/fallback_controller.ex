defmodule LLAdminWeb.FallbackController do
  use LLAdminWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(LLAdminWeb.ErrorView)
    |> render(:"404")
  end
end
