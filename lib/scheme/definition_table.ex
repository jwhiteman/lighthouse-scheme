defmodule Scheme.DefinitionTable do
  @name __MODULE__

  def start_link do
    Agent.start_link(fn -> HashDict.new end, name: @name)
  end

  def put(ident, body) do
    Agent.update(@name, &(Dict.put &1, ident, body))
  end

  def get(ident) do
    Agent.get(@name, &(Dict.get &1, ident))
  end
end
