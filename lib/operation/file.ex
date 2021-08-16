defmodule Operation.File do
  alias Mix.Shell.IO, as: Shell
  alias Operation.Entry

  def read do
    {:ok, result} = File.read("cordinates.txt")

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
    [position, cordinate | next] = tail

    cordinate
    |> Entry.cordinates(grid, Entry.position(position))
    |> Shell.info()

    auto_mode(grid, next)
  end
end
