defmodule LLAdminWeb.LayoutView do
  use LLAdminWeb, :view

  def render_layout(layout, assigns, do: content) do
    render(layout, Map.put(assigns, :inner_layout, content))
  end

  def active_link(conn, text, kw \\ []) do
    path = Keyword.get(kw, :to)
    {active_class, kw} = Keyword.pop(kw, :active, "active")

    kw =
      case is_active(conn, path) do
        true -> Keyword.update(kw, :class, active_class, &(&1 <> " " <> active_class))
        _ -> kw
      end

    link(text, kw)
  end

  def is_active(conn, path) do
    conn.request_path == path
  end
end
