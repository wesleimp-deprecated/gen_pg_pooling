defmodule GenPgPoolingWeb.API.VolunteersController do
  use GenPgPoolingWeb, :controller

  def index(conn, _params) do
    volunteers = GenPgPooling.Volunteers.list_volunteers()

    conn
    |> put_status(200)
    |> json(volunteers)
  end
end
