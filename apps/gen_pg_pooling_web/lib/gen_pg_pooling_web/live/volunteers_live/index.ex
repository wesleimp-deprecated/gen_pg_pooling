defmodule GenPgPoolingWeb.VolunteersLive.Index do
  use GenPgPoolingWeb, :live_view

  alias GenPgPooling.Volunteers
  alias GenPgPooling.Volunteers.Volunteer

  @impl true
  def mount(_params, _session, socket) do
    Volunteers.subscribe()

    volunteers =
      Volunteers.list_volunteers()
      |> Enum.map(&Volunteer.fill_virtual_fields/1)

    IO.inspect(volunteers)

    socket = assign(socket, volunteers: volunteers)

    {:ok, socket, temporary_assigns: [volunteers: []]}
  end

  @impl true
  def render(assigns) do
    GenPgPoolingWeb.VolunteersView.render("index.html", assigns)
  end

  @impl true
  def handle_event("create-volunteer", _params, socket) do
    {:ok, _} =
      %{
        name: Faker.Person.name(),
        age: Enum.random(25..45)
      }
      |> Volunteers.create_volunteer()

    {:noreply, socket}
  end

  @impl true
  def handle_event("toggle-supervisor", %{"id" => id, "action" => action}, socket) do
    volunteer = Volunteers.get_volunteer!(id)

    {:ok, volunteer} = toggle_supervisor(volunteer, action)

    {:noreply, update(socket, :volunteers, fn volunteers -> [volunteer | volunteers] end)}
  end

  defp toggle_supervisor(volunteer, "add") do
    {:ok, pid} = Volunteer.DynamicSupervisor.add_volunteer_to_supervisor(volunteer)
    {:ok, %Volunteer{volunteer | pid: pid}}
  end

  defp toggle_supervisor(volunteer, "remove") do
    %{pid: pid} = volunteer = Volunteer.fill_virtual_fields(volunteer)

    :ok = Volunteer.Actor.stop_supervisor(pid)
    {:ok, %Volunteer{volunteer | pid: nil}}
  end

  @impl true
  def handle_info({:volunteer_created, volunteer}, socket) do
    {:noreply, update(socket, :volunteers, fn volunteers -> [volunteer | volunteers] end)}
  end
end
