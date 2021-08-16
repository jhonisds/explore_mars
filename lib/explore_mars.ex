defmodule ExploreMars do
  @moduledoc """
  Documentation for `ExploreMars`.
  """
  use GenServer

  alias Probe.Cordinate

  # Client
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

  # Server (callbacks)
  def handle_call(:move, _from, probe) do
    state = %{probe | position: Cordinate.move(probe.position.direction, probe.position)}
    {:reply, state, state}
  end

  def handle_call(:left, _from, probe) do
    state = %{probe | position: Cordinate.rotate_left(probe.position.direction, probe.position)}
    {:reply, state, state}
  end

  def handle_call(:right, _from, probe) do
    state = %{probe | position: Cordinate.rotate_right(probe.position.direction, probe.position)}
    {:reply, state, state}
  end

  def handle_call(:view, _from, probe) do
    {:reply, probe.position, probe.position}
  end
end
