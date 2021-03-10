defmodule GenPgPooling.Volunteers do
  import Ecto.Query
  alias GenPgPooling.Repo

  alias GenPgPooling.Volunteers.Volunteer

  @topic "volunteers"

  def subscribe do
    Phoenix.PubSub.subscribe(GenPgPooling.PubSub, @topic)
  end

  def list_volunteers do
    Repo.all(from v in Volunteer, order_by: [desc: v.id])
  end

  def list_volunteers_delay(delay) do
    Repo.query("SELECT sleep(#{delay})")
    Repo.all(from v in Volunteer, order_by: [desc: v.id])
  end

  def update_age do
    Repo.query("SELECT sleep(#{Enum.random(200..3000)})")

    {:ok, volunteer} =
      Repo.all(from(v in Volunteer))
      |> List.first()
      |> Volunteer.changeset(%{
        age: Enum.random(15..30)
      })
      |> Repo.update()

    volunteer
  end

  def get_volunteer!(id), do: Repo.get!(Volunteer, id)

  def create_volunteer(attrs \\ %{}) do
    %Volunteer{}
    |> Volunteer.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:volunteer_created)
  end

  def broadcast(volunteer, event) do
    Phoenix.PubSub.broadcast(
      GenPgPooling.PubSub,
      @topic,
      {event, volunteer}
    )

    {:ok, volunteer}
  end
end
