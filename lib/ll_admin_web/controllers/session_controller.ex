defmodule LLAdminWeb.SessionController do
  use LLAdminWeb, :controller

  def new(conn, _params) do
    oauth_google_url = ElixirAuthGoogle.generate_oauth_url(conn)
    render(conn, "new.html", oauth_google_url: oauth_google_url)
  end

  @doc """
  `index/2` handles the callback from Google Auth API redirect.
  """
  def create(conn, %{"code" => code}) do
    {:ok, token} = ElixirAuthGoogle.get_token(code, conn)
    {:ok, profile} = ElixirAuthGoogle.get_user_profile(token.access_token)

    conn
    |> Plug.Conn.put_session(:current_user, profile)
    |> redirect(to: Routes.app_path(conn, :index))
  end

  def delete(conn, _params) do
    conn
    |> Plug.Conn.clear_session()
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
