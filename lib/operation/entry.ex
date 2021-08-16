defmodule Operation.Entry do
  alias Cli.Interface
  alias Probe.{Cordinate, Position}

  @surface ~r/(\d+)\s+(\d+)/
  @position ~r/(\d+)\s+(\d+)\s+([ˆNSEW])/
  @cordinates ~r/[MLR]/

  def surface(input) do
    {x, y} =
      @surface
      |> Regex.run(input)
      |> Enum.drop(1)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()

    Cordinate.grid(%{x: x, y: y})
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

  def cordinates(input, grid, pos) do
    attrs = %{
      grid: grid,
      position: pos
    }

    @cordinates
    |> Regex.scan(input)
    |> case do
      [] ->
        Interface.display_invalid_option(
          "Invalid cordinates: #{input}. Valid cordinates [M-L-R]."
        )

      result ->
        result
        |> List.flatten()
        |> Cordinate.route(attrs)
        |> Position.output()
    end
  end
end
