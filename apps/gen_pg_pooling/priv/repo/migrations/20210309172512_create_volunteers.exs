defmodule GenPgPooling.Repo.Migrations.CreateVolunteers do
  use Ecto.Migration

  def change do
    create table(:volunteers) do
      add :name, :string
      add :age, :integer

      timestamps()
    end
  end
end
