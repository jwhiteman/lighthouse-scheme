defmodule Scheme.Evaluator do
  def eval(str) when is_binary(str) do
    str
      |> Scheme.Parser.parse
      |> eval
  end

  def eval(exps) when is_list(exps) do
    Enum.map(exps, &Scheme.Interpreter.value(&1)) |> List.last
  end
end
