defmodule Scheme.Evaluator do
  def run(str) do
    Scheme.DefinitionTable.start_link

    str
    |> Scheme.Parser.parse
    |> eval
  end

  def eval(exps) do
    Enum.map(exps, &Scheme.Interpreter.value(&1)) |> List.last
  end
end
