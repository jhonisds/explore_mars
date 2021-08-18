defmodule Probe.Coordinate do
  @moduledoc """
  Module `Coordinate`. Defines the structure for grid and controls
  the probe movement. `5 5`
  """

  alias ExploreMars

  defstruct [:x, :y]

  @move %{"M" => :move, "L" => :left, "R" => :right}

  def grid(axis) do
    %__MODULE__{
      x: axis.x,
      y: axis.y
    }
  end

  def route(path, attrs) do
    result =
      path
      |> Enum.map(&Map.fetch!(@move, &1))

    {:ok, pid} = ExploreMars.start_link(attrs)

    Enum.each(result, fn m -> ExploreMars.action(pid, m) end)
    ExploreMars.view(pid)
  end

  def move(:north, position), do: %{position | y: position.y + 1}
  def move(:south, position), do: %{position | y: position.y - 1}
  def move(:east, position), do: %{position | x: position.x + 1}
  def move(:west, position), do: %{position | x: position.x - 1}

  def rotate_left(:north, position), do: %{position | direction: :west}
  def rotate_left(:south, position), do: %{position | direction: :east}
  def rotate_left(:east, position), do: %{position | direction: :north}
  def rotate_left(:west, position), do: %{position | direction: :south}

  def rotate_right(:north, position), do: %{position | direction: :east}
  def rotate_right(:south, position), do: %{position | direction: :west}
  def rotate_right(:east, position), do: %{position | direction: :south}
  def rotate_right(:west, position), do: %{position | direction: :north}
end
