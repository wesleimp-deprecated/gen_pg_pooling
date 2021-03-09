defmodule GenPgPooling.Volunteers.Volunteer.DynamicSupervisor do
  use DynamicSupervisor

  alias GenPgPooling.Volunteers.Volunteer

  def start_link(opts) do
    DynamicSupervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_), do: DynamicSupervisor.init(strategy: :one_for_one)

  def add_volunteer_to_supervisor(%Volunteer{id: id}) do
    child_spec = %{
      id: GenPgPooling.Volunteers.Volunteer.Actor,
      start: {GenPgPooling.Volunteers.Volunteer.Actor, :start_link, [id]},
      restart: :transient
    }

    case DynamicSupervisor.start_child(__MODULE__, child_spec) do
      {:error, {:already_started, pid}} -> {:ok, pid}
      {:ok, pid} -> {:ok, pid}
    end
  end
end
