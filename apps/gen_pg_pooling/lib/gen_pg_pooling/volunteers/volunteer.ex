defmodule GenPgPooling.Volunteers.Volunteer do
  use Ecto.Schema

  import Ecto.Changeset

  alias GenPgPooling.Volunteers.Volunteer

  @fields_to_export ~w(id name age)a

  @derive {Jason.Encoder, only: @fields_to_export}

  schema "volunteers" do
    field :name, :string
    field :age, :integer

    field :pid, :any, virtual: true

    timestamps()
  end

  def changeset(volunteer, attrs) do
    volunteer
    |> cast(attrs, [:name, :age])
    |> validate_required([:name, :age])
  end

  def fill_virtual_fields(volunteer) do
    %__MODULE__{volunteer | pid: Volunteer.Registry.get_volunteer(volunteer.id)}
  end
end
