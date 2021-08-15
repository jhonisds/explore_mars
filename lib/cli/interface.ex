defmodule Cli.Interface do
  alias Mix.Shell.IO, as: Shell

  @surface ~r/(\d+)\s+(\d+)/

  def entry_surface do
    @surface
    |> Regex.run(Shell.prompt("Surface:"))
    |> Enum.drop(1)
    |> Enum.map(&String.to_integer/1)
  end

  defp options,
    do: [
      "Read file",
      "Enter Coordinates",
      "Abort launch"
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
        display_invalid_option()
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
        display_invalid_option()
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

  def display_invalid_option do
    Shell.cmd("clear")
    Shell.error("Invalid option.")
    Shell.prompt("Press enter to try again.")
    Shell.cmd("clear")
  end

  defp confirm(mode) do
    Shell.cmd("clear")
    if Shell.yes?("Confirm: #{mode.description}"), do: launch_choice(mode.index), else: start()
  end

  defp launch_choice(mode) do
    case mode do
      0 -> Shell.info("file")
      1 -> Shell.info("command")
      2 -> Shell.cmd("exit")
    end
  end
end
