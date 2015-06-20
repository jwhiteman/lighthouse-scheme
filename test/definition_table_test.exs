defmodule DefinitionTableTest do
  use ExUnit.Case

  import Scheme.DefinitionTable

  test "adding definitions" do
    start_link

    put(:sadd1, [:lambda, [:x], [:add1, :x]])

    assert get(:sadd1) == [:lambda, [:x], [:add1, :x]]
  end
end
