defmodule Scheme.Evaluator do
  def run(str) do
    str
    |> Scheme.Parser.parse
    |> eval
  end

  def eval(exps) do
    Enum.map(exps, &Scheme.Interpreter.value(&1)) |> List.last
  end
end
