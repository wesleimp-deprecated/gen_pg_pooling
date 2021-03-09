defmodule GenPgPooling.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @volunteer_actor [
    GenPgPooling.Volunteers.Volunteer.Registry.child_spec(),
    GenPgPooling.Volunteers.Volunteer.DynamicSupervisor,
    GenPgPooling.Volunteers.Volunteer.StateHydrator
  ]

  def start(_type, _args) do
    children =
      [
        GenPgPooling.Repo,
        {Phoenix.PubSub, name: GenPgPooling.PubSub}
      ] ++ @volunteer_actor

    Supervisor.start_link(children, strategy: :one_for_one, name: GenPgPooling.Supervisor)
  end
end
