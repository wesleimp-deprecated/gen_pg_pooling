defmodule GenPgPooling.Volunteers.Volunteer.Registry do
  def child_spec do
    Registry.child_spec(
      keys: :unique,
      name: __MODULE__,
      partitions: System.schedulers_online()
    )
  end

  def get_volunteer(volunteer_id) do
    case Registry.lookup(__MODULE__, volunteer_id) do
      [{pid, _}] -> pid
      [] -> nil
    end
  end
end
