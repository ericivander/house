defmodule House.Supervisor do
  use Supervisor

  def start_link do
    IO.puts("Supervisor started")
    Supervisor.start_link(__MODULE__, [], [name: :house_supervisor])
  end

  def init([]) do
    children =
      [
        Supervisor.Spec.worker(House.Stash, [[], [name: :my_stash]])
      ]

    Supervisor.Spec.supervise(children, strategy: :one_for_one)
  end
end