defmodule Scheme do
  def start do
    Scheme.DefinitionTable.start_link

    Scheme.REPL.start
  end

  def parse(scheme) do
    Scheme.Parser.parse(scheme)
  end

  def eval(scheme) do
    Scheme.Evaluator.run(scheme)
  end
end
