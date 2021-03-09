defmodule GenPgPoolingWeb.VolunteersView do
  use GenPgPoolingWeb, :view

  def print_pid(pid) do
    Phoenix.HTML.safe_to_string(pid)
  end
end
