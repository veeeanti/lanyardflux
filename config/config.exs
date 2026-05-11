import Config

config :lanyard,
  fluxer_spotify_activity_id: "spotify:1"

import_config "#{Mix.env()}.exs"
