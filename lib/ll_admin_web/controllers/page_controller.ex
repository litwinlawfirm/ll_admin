defmodule LLAdminWeb.PageController do
  use LLAdminWeb, :controller

  action_fallback LLAdminWeb.FallbackController

  plug :put_layout, :page

  @home_slug "home"

  def index(conn, _params) do
    redirect(conn, to: Routes.page_path(conn, :show, @home_slug))
  end

  def show(conn, %{"slug" => slug}) do
    with {:ok, page} <- LLAdmin.get_page_by_slug(slug) do
      render(conn, "show.html", pages: LLAdmin.get_pages(), page: page)
    end
  end
end
