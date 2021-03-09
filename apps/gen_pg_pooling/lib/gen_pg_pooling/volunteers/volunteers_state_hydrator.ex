defmodule GenPgPooling.Volunteers.Volunteer.StateHydrator do
  use GenServer, restart: :transient

  alias GenPgPooling.Volunteers
  alias GenPgPooling.Volunteers.Volunteer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_) do
    Volunteers.list_volunteers()
    |> Enum.each(&Volunteer.DynamicSupervisor.add_volunteer_to_supervisor/1)

    :ignore
  end
end
