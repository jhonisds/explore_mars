defmodule Operation.File do
  @moduledoc """
  Module `File`. Responsible for reading the coordinates in the file.
  """

  alias Mix.Shell.IO, as: Shell
  alias Operation.Entry

  def read do
    {:ok, result} = File.read("coordinates.txt")

    {head, tail} =
      result
      |> String.split("\n")
      |> Enum.split(1)

    grid =
      head
      |> List.first()
      |> Entry.surface()

    auto_mode(grid, tail)
  end

  defp auto_mode(_grid, []) do
    IO.inspect("Launch successful.")
  end

  defp auto_mode(grid, tail) do
    [position, coordinate | next] = tail

    coordinate
    |> Entry.coordinates(grid, Entry.position(position, grid))
    |> Shell.info()

    auto_mode(grid, next)
  end
end
