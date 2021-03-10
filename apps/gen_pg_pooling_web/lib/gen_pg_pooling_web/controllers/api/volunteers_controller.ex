defmodule GenPgPoolingWeb.API.VolunteersController do
  use GenPgPoolingWeb, :controller

  def index(conn, _params) do
    volunteers = GenPgPooling.Volunteers.list_volunteers_delay(Enum.random(300..2000))

    conn
    |> put_status(200)
    |> json(volunteers)
  end

  def update(conn, _params) do
    volunteer = GenPgPooling.Volunteers.update_age()

    conn
    |> put_status(200)
    |> json(volunteer)
  end
end
