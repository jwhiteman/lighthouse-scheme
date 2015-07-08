defmodule Scheme.CLI do
  def main([]), do: Scheme.repl

  def main(argv) do
    argv |> to_string |> Scheme.eval_file
  end
end
