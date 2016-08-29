defmodule House do
  use Application

  def start(_type, _args) do
    IO.puts("App Started")
    House.Supervisor.start_link()
  end
end
