defmodule Cli.Interface do
  @moduledoc """
  Module `Interface`. Defines interface user.
  """

  alias Mix.Shell.IO, as: Shell
  alias Operation.{Entry, File}

  defp options,
    do: [
      "Read file",
      "Enter coordinates",
      "Abort mission"
    ]

  def start do
    options()
    |> ask_for_options()
    |> confirm()
  end

  def ask_for_options(options) do
    index = ask_for_index(options)

    case Enum.at(options, index) do
      nil ->
        display_invalid_option("Invalid option.")
        ask_for_options(options)

      result ->
        %{index: index, description: result}
    end
  end

  def ask_for_index(options) do
    answer =
      options
      |> display_options()
      |> operations()
      |> Shell.prompt()
      |> Integer.parse()

    case answer do
      :error ->
        display_invalid_option("Invalid option.")
        ask_for_index(options)

      {option, _} ->
        option - 1
    end
  end

  def display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} -> Shell.info("#{index} - #{option}") end)

    options
  end

  def operations(options) do
    options = Enum.join(1..Enum.count(options), ",")
    "Which mode? [#{options}]\n"
  end

  def display_invalid_option(message) do
    Shell.cmd("clear")
    Shell.error(message)
    Shell.cmd("exit")
    Shell.prompt("Press enter to try again.")
    Shell.cmd("clear")
    start()
  end

  defp confirm(mode) do
    Shell.cmd("clear")
    if Shell.yes?("Confirm: #{mode.description}"), do: launch_choice(mode.index), else: start()
  end

  defp launch_choice(mode) do
    case mode do
      0 ->
        File.read()

      1 ->
        manual_mode()

      2 ->
        Shell.cmd("exit")
    end
  end

  defp manual_mode do
    grid =
      Shell.prompt("Surface:")
      |> Entry.surface()

    pos =
      Shell.prompt("Initial position:")
      |> Entry.position(grid)

    Shell.prompt("Enter coordinates:")
    |> Entry.coordinates(grid, pos)
    |> Shell.info()
  end
end
