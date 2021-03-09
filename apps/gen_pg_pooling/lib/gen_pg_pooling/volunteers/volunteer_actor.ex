defmodule GenPgPooling.Volunteers.Volunteer.Actor do
  use GenServer, restart: :transient

  alias GenPgPooling.Volunteers.Volunteer

  def stop_supervisor(pid) do
    GenServer.stop(pid)
  end

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: {:via, Registry, {Volunteer.Registry, state}})
  end

  def init(volunteer_id) do
    volunteer =
      volunteer_id
      |> GenPgPooling.Volunteers.get_volunteer!()
      |> GenPgPooling.Volunteers.Volunteer.fill_virtual_fields()

    IO.inspect(volunteer)
    {:ok, volunteer}
  end
end
