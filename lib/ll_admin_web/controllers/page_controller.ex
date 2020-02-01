defmodule LLAdminWeb.PageController do
  use LLAdminWeb, :controller
  import Ecto.Query
  alias LLAdmin.{Repo, Page}

  plug :put_layout, :page

  def index(conn, _params) do
    pages = get_pages()
    render(conn, "index.html", pages: pages)
  end

  def show(conn, %{"slug" => slug}) do
    pages = get_pages()

    case Repo.get_by(Page, slug: slug) do
      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(LLAdminWeb.ErrorView)
        |> render(:"404")

      page ->
        render(conn, "show.html", pages: pages, page: page)
    end
  end

  defp get_pages() do
    Page
    |> select([:id, :title, :slug])
    |> Repo.all()
  end
end
