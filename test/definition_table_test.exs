defmodule DefinitionTableTest do
  use ExUnit.Case

  import Scheme.DefinitionTable

  test "adding definitions" do
    Scheme.DefinitionTable.start_link

    Scheme.DefinitionTable.put(:sadd1, [:lambda, [:x], [:add1, :x]])

    assert Scheme.DefinitionTable.get(:sadd1) == [:lambda, [:x], [:add1, :x]]
  end
end
