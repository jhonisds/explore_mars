defmodule Operation.Entry do
  @moduledoc """
  Module `Entry`. Defines input data.
  """

  alias Cli.Interface
  alias Probe.{Coordinate, Position}

  @surface ~r/(\d+)\s+(\d+)/
  @position ~r/(\d+)\s+(\d+)\s+([ˆNSEW])/
  @coordinates ~r/[MLR]/

  def surface(input) do
    {x, y} =
      @surface
      |> Regex.run(input)
      |> Enum.drop(1)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()

    Coordinate.grid(%{x: x, y: y})
  rescue
    _ in Protocol.UndefinedError ->
      Interface.display_invalid_option("Invalid surface: #{input}.Enter 2 number.")
  end

  def position(input) do
    [x, y, direction] =
      @position
      |> Regex.run(input)
      |> List.delete_at(0)

    {pos_x, pos_y, direction} =
      [x, y]
      |> Enum.map(&String.to_integer/1)
      |> List.insert_at(-1, direction)
      |> List.to_tuple()

    result = %{x: pos_x, y: pos_y, direction: direction}
    Position.initial(result)
  rescue
    _ in FunctionClauseError ->
      Interface.display_invalid_option(
        "Invalid position: #{input}.Enter 2 numbers and a valid direction [N-S-E-W]."
      )
  end

  def coordinates(input, grid, pos) do
    attrs = %{
      grid: grid,
      position: pos
    }

    @coordinates
    |> Regex.scan(input)
    |> case do
      [] ->
        Interface.display_invalid_option(
          "Invalid coordinates: #{input}. Valid coordinates [M-L-R]."
        )

      result ->
        result
        |> List.flatten()
        |> Coordinate.route(attrs)
        |> Position.output()
    end
  end
end
