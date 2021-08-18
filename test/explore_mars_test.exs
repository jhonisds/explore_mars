defmodule ExploreMarsTest do
  use ExUnit.Case, async: true

  alias ExploreMars

  @attrs %{
    grid: %Probe.Coordinate{x: 5, y: 5},
    position: %Probe.Position{direction: :north, x: 1, y: 2}
  }

  setup do
    {:ok, pid} = ExploreMars.start_link(@attrs)

    [
      probe: pid
    ]
  end

  describe "action/2" do
    test "when actived should move the probe", %{probe: probe} do
      result = ExploreMars.action(probe, :move)
      expected = %Probe.Position{direction: :north, x: 1, y: 3}

      assert expected == result.position
    end

    test "should rotate the probe 90 degrees to left", %{probe: probe} do
      result = ExploreMars.action(probe, :left)
      expected = %Probe.Position{direction: :west, x: 1, y: 2}

      assert expected == result.position
    end

    test "should rotate the probe 90 degrees to right", %{probe: probe} do
      result = ExploreMars.action(probe, :right)
      expected = %Probe.Position{direction: :east, x: 1, y: 2}

      assert expected == result.position
    end
  end
end
