defmodule Cli.Main do
  alias Mix.Shell.IO, as: Shell
  alias Cli.Interface

  def start_launch do
    welcome_message()
    Interface.start()
  end

  defp welcome_message do
    Shell.info("=== Explore Mars ===")
    Shell.prompt("Press Enter to continue")
    Shell.cmd("clear")
    Shell.info("Enter launch mode:")
  end
end
