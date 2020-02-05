defmodule LLAdminWeb.ViewHelpers do
  def active_link(conn, text, kw \\ []) do
    path = Keyword.get(kw, :to)
    {active_class, kw} = Keyword.pop(kw, :active, "active")

    kw =
      case is_active(conn, path) do
        true -> Keyword.update(kw, :class, active_class, &(&1 <> " " <> active_class))
        _ -> kw
      end

    Phoenix.HTML.Link.link(text, kw)
  end

  def is_active(conn, path) do
    String.match?(conn.request_path, ~r/^#{path}/)
  end

  def lock_class(page, class \\ "locked") do
    if lock(page), do: class, else: ""
  end

  def lock(page) do
    page.slug == "home"
  end
end
