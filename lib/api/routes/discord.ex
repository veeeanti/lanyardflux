defmodule Lanyard.Api.Routes.Fluxer do
  alias Lanyard.Api.Util

  use Plug.Router
  plug(:match)
  plug(:dispatch)

  get "/" do
    # Fluxyard invite URL
    Util.redirect(conn, "https://fluxer.gg/VEQH9Spf")
  end
end
