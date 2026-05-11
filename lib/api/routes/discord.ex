defmodule Lanyard.Api.Routes.Fluxer do
  alias Lanyard.Api.Util

  use Plug.Router
  plug(:match)
  plug(:dispatch)

  get "/" do
    # Fluxer invite URL
    Util.redirect(conn, "https://fluxer.gg/invite/lanyard")
  end
end
