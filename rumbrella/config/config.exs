# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
import Config

for config <- "../apps/*/config/config.exs" |> Path.expand(__DIR__) |> Path.wildcard() do
  import_config config
end

