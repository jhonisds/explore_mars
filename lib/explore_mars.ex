defmodule ExploreMars do
  @moduledoc """
  Module `ExploreMars`. Provides state `GenServer` to control the probe.
  """
  use GenServer

  alias Probe.Coordinate

  @doc """
  Init `state`.
  """
  def init(value) do
    {:ok, value}
  end

  def start_link(attrs) do
    GenServer.start_link(__MODULE__, attrs)
  end

  def action(pid, item) do
    GenServer.call(pid, item)
  end

  def view(pid) do
    GenServer.call(pid, :view)
  end

  @doc """
  Callback.
  """
  def handle_call(:move, _from, probe) do
    state = %{probe | position: Coordinate.move(probe.position.direction, probe.position)}
    {:reply, state, state}
  end

  def handle_call(:left, _from, probe) do
    state = %{probe | position: Coordinate.rotate_left(probe.position.direction, probe.position)}
    {:reply, state, state}
  end

  def handle_call(:right, _from, probe) do
    state = %{probe | position: Coordinate.rotate_right(probe.position.direction, probe.position)}
    {:reply, state, state}
  end

  def handle_call(:view, _from, probe) do
    {:reply, probe.position, probe.position}
  end
end
