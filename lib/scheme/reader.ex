defmodule Scheme.Reader do

  @lparen 40
  @rparen 41

  def read do
    read(1)
  end

  def read(n) do
    IO.gets("#;#{n}> ") |> process("") |> Scheme.Printer.print |> IO.puts

    read(n + 1)
  end

  def process(str, acc) do
    current_total = acc <> clean(str)

    case reader(current_total) do
      { :ok, :ignore }   ->
        IO.gets("") |> process(current_total)
      { :ok, :evaluate } ->
        Scheme.Evaluator.eval(current_total)
      { :ok, :recur }    ->
        IO.gets("")  |> process(current_total)
    end
  end

  def clean(str) do
    String.replace str, "\n", " "
  end

  def reader(str) do
    cond do
      is_only_whitespace(str) ->
        { :ok, :ignore }
      is_non_list(str) ->
        { :ok, :evaluate }
      is_balanced(str) ->
        { :ok, :evaluate }
      has_more_left_parens(str) ->
        { :ok, :recur }
      true ->
        { :error, :unexpected_list_terminator }
    end
  end

  def num_left_parens(str) do
    count_num_char(str, @lparen)
  end

  def num_right_parens(str) do
    count_num_char(str, @rparen)
  end

  defp has_more_left_parens(str) do
    num_left_parens(str) > num_right_parens(str)
  end

  defp is_balanced(str) do
    num_left_parens(str) == num_right_parens(str)
  end

  defp is_non_list(str) do
    num_left_parens(str) == 0 &&
      num_right_parens(str) == 0
  end

  defp is_only_whitespace(str), do: String.match?(str, ~r/^\s+$/)

  defp count_num_char(str, char) do
    Enum.filter(to_char_list(str), fn (e) -> e == char end) |> length
  end
end
