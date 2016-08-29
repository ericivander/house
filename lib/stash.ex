defmodule House.Stash do
  use GenServer

  @online_table :stash

  def get(key) do
    value = :ets.lookup(@online_table, key) |> Enum.at(0)
    value = 
    case value do
      nil -> nil
      {^key, value} -> value
    end
  end

  def start_link(state, opts \\ []) do
    IO.puts("Stash started")
    GenServer.start_link(__MODULE__, state, opts)# return
  end

  def put(key, value) do
    GenServer.call(:my_stash, {:put, key, value})
  end

  def init([]) do
    :ets.new(@online_table, [:named_table])

    {:ok, []}
  end

  def handle_call({:put, key, value}, _from, state) do
    :ets.insert(@online_table, {key, value})

    {:reply, :ok, state}
  end
end
