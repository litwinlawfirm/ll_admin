defmodule LLAdmin do
  @moduledoc """
  LLAdmin keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  import Ecto.Query
  alias LLAdmin.{Page, Repo}

  def get_pages() do
    Page
    |> select([:id, :title, :slug])
    |> order_by(asc: :inserted_at)
    |> Repo.all()
  end

  def get_page_by_slug(slug) do
    case Repo.get_by(Page, slug: slug) do
      nil -> {:error, :not_found}
      page -> {:ok, page}
    end
  end

  # taken from https://github.com/h4cc/slugger/blob/master/lib/slugger.ex
  def slugify(text) do
    sep = "-"

    text
    # Handle "Sheep's Milk" so it will be "sheeps-milk" instead of "sheep-s-milk"
    |> String.replace(~r/['’]s/u, "s")
    |> String.downcase()
    |> String.replace(~r/([^a-z0-9가-힣])+/, sep)
    |> String.trim(sep)
  end
end
