defmodule Probe.Position do
  defstruct [:x, :y, :direction]

  @cardinal %{"N" => :north, "S" => :south, "E" => :east, "W" => :west}
  @output %{north: "N", south: "S", east: "E", west: "W"}

  def initial(position) do
    %__MODULE__{
      x: position.x,
      y: position.y,
      direction: @cardinal[position.direction]
    }
  end

  def output(position) do
    "#{position.x} #{position.y} #{@output[position.direction]}"
  end
end
