defmodule Scheme.DefinitionTable do
  use GenServer

  def start_link do
    GenServer.start_link __MODULE__, [], name: __MODULE__
  end

  def init(_) do
    {:ok, HashDict.new}
  end

  def put(ident, body) do
    GenServer.cast __MODULE__, {:put, ident, body}
  end

  def get(ident) do
    GenServer.call __MODULE__, {:get, ident}
  end

  def handle_cast({:put, ident, body}, table) do
    {:noreply, Dict.put(table, ident, body)}
  end

  def handle_call({:get, ident}, _from, table) do
    {:reply, Dict.get(table, ident), table}
  end
end
