defmodule ExploreMarsTest do
  use ExUnit.Case
  doctest ExploreMars

  test "greets the world" do
    assert ExploreMars.hello() == :world
  end
end
