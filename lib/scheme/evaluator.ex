defmodule Scheme.Evaluator do
  def run(str) do
    Scheme.DefinitionTable.start_link

    str
    |> Scheme.Parser.parse
    |> eval
  end

  defp eval(expressions) do
    List.foldl(expressions, nil, fn (exp, _acc) -> Scheme.Interpreter.value(exp) end)
  end
end
