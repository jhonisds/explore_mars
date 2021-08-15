defmodule Mix.Tasks.Start do
  use Mix.Task

  alias Cli.Main

  def run(_), do: Main.start_launch()
end
