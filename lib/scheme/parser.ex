defmodule Scheme.Parser do
  def parse(str) do
    {:ok, tokens, _} = lex(str)
    {:ok, list}      = :sparser.parse(tokens)
    list
  end

  def lex(str) do
    str |> to_char_list |> :slexer.string
  end
end
