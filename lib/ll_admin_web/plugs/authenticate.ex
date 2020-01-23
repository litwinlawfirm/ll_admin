defmodule LLAdminWeb.Plugs.Authenticate do
  import Plug.Conn
  import Phoenix.Controller
  alias LLAdminWeb.Router.Helpers, as: Routes

  def init(_params) do
  end

  def call(conn, _params) do
    user = Plug.Conn.get_session(conn, :current_user)

    case user do
      nil ->
        conn
        |> put_flash(:error, "Please sign in before continuing.")
        |> redirect(to: Routes.session_path(conn, :new))
        |> halt()

      current_user ->
        conn
        |> assign(:current_user, current_user)
    end
  end
end
