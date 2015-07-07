defmodule Scheme do
  def start do
    Scheme.DefinitionTable.start_link
    Scheme.Library.load
  end

  def repl do
    start

    Scheme.REPL.start
  end

  def eval(scheme) do
    Scheme.Evaluator.eval(scheme) |> Scheme.Printer.print
  end

  # helpful for debugging.
  def parse(scheme) do
    Scheme.Parser.parse(scheme)
  end
end
