defmodule House.Stack do
  use GenServer

  def create(stack_atom) do
    Supervisor.start_child(:house_supervisor, Supervisor.Spec.worker(House.Stack, [[], [name: stack_atom]], [id: stack_atom]))
  end

  def start_link(state, opts \\ []) do
    IO.puts("Stack started")
    GenServer.start_link(__MODULE__, state, opts)
  end

  def init([]) do
    key = :my_stack
    t = House.Stash.get(key)
    if t == nil do
      t = []
    end
    {:ok, t}
  end

  def handle_call(:pop, _from, [h | t]) do
    {:reply, h, t}
  end

  def handle_cast({:push, h}, t) do
    _ = 10/h
    {:noreply, [h | t]}
  end

  def terminate(_reason, t) do
    IO.puts("Stack terminated")
    key = :my_stack
    value = t
    House.Stash.put(key, value)
  end
end