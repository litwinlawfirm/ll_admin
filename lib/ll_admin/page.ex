defmodule LLAdmin.Page do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pages" do
    field :content, :string
    field :slug, :string
    field :title, :string

    timestamps()
  end

  @attributes ~w(content slug title)a
  @required_attributes ~w(content title)a

  @doc false
  def changeset(change_or_struct, attrs \\ %{}) do
    change_or_struct
    |> cast(attrs, @attributes)
    |> validate_required(@required_attributes)
    |> generate_slug_from(:title)
    |> unique_constraint(:slug)
  end

  defp generate_slug_from(change, source_key) do
    case get_change(change, source_key) do
      nil -> change
      source_value -> put_change(change, :slug, LLAdmin.slugify(source_value))
    end
  end
end
