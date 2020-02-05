defmodule LLAdminWeb.CMSController do
  use LLAdminWeb, :controller
  import Ecto.Query
  alias LLAdmin.{Repo, Page}

  action_fallback LLAdminWeb.FallbackController

  plug :put_layout, :cms

  def index(conn, _params) do
    render(conn, "index.html", pages: LLAdmin.get_pages())
  end

  def new(conn, _params) do
    page = %Page{title: "Your Title...", slug: "your-title", content: "Add your content here..."}
    render(conn, "new.html", change: Page.changeset(page))
  end

  def edit(conn, %{"slug" => slug}) do
    with {:ok, page} <- LLAdmin.get_page_by_slug(slug) do
      render(conn, "edit.html", change: Page.changeset(page))
    end
  end

  def create(conn, %{"page" => page_params}) do
    with change <- Page.changeset(%Page{}, page_params),
         {:ok, page} <- Repo.insert(change) do
      conn
      |> put_flash(:success, "Created Page.")
      |> redirect(to: Routes.cms_path(conn, :edit, page.slug))
    else
      {:error, change} ->
        conn
        |> put_flash(:error, "Sorry, there was a problem.")
        |> render("edit.html", change: change)
    end
  end

  def update(conn, %{"slug" => slug, "page" => page_params}) do
    with {:ok, page} <- LLAdmin.get_page_by_slug(slug),
         change <- Page.changeset(page, page_params),
         {:ok, page} <- Repo.update(change) do
      conn
      |> put_flash(:success, "Updated Page.")
      |> redirect(to: Routes.cms_path(conn, :edit, page.slug))
    else
      {:error, change} ->
        conn
        |> put_flash(:error, "Sorry, there was a problem.")
        |> render("edit.html", change: change)
    end
  end

  def delete(conn, %{"slug" => slug}) do
    with {:ok, page} <- LLAdmin.get_page_by_slug(slug),
         {:ok, page} <- Repo.delete(page) do
      conn
      |> put_flash(:success, "Deleted Page.")
      |> redirect(to: Routes.cms_path(conn, :index))
    else
      {:error, change} ->
        conn
        |> put_flash(:error, "Sorry, there was a problem.")
        |> render("index.html", change: change)
    end
  end
end
