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
  @required_attributes ~w(content slug title)a

  @doc false
  def changeset(change_or_struct \\ %__MODULE__{}, attrs) do
    change_or_struct
    |> cast(attrs, @attributes)
    |> validate_required(@required_attributes)
    |> unique_constraint(:slug)
  end
end
