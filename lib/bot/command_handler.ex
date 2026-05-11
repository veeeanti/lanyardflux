defmodule Lanyard.FluxerBot.CommandHandler do
  @command_map %{
    "get" => Lanyard.FluxerBot.Commands.Get,
    "set" => Lanyard.FluxerBot.Commands.Set,
    "del" => Lanyard.FluxerBot.Commands.Del,
    "apikey" => Lanyard.FluxerBot.Commands.ApiKey,
    "kv" => Lanyard.FluxerBot.Commands.KV,
    "help" => Lanyard.FluxerBot.Commands.KV
  }

  def handle_message(payload) do
    case payload.data do
      # Don't handle messages from other bots
      %{"author" => %{"bot" => true}} ->
        :ok

      %{"content" => content} ->
        if String.starts_with?(content, Application.get_env(:lanyard, :command_prefix)) do
          [attempted_command | args] =
            content
            |> String.to_charlist()
            |> tl()
            |> to_string()
            |> String.split(" ")

          unless @command_map[attempted_command] == nil do
            @command_map[attempted_command].handle(args, payload.data)
          end
        end

      _ ->
        :ok
    end
  end

  def handle_command(_unknown_command, _args), do: :ok
end
