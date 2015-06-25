defmodule Scheme.REPL do

  @lparen 40
  @rparen 41

  def start do
    repl(1)
  end

  def repl(n) do
    IO.gets("#;#{n}> ") |> process("") |> Scheme.Printer.print |> IO.puts

    repl(n + 1)
  end

  def process(str, acc) do
    current_total = acc <> clean(str)

    case what_to_do(str, current_total) do
      { :ok, :ignore }   ->
        IO.gets("") |> process(current_total)
      { :ok, :evaluate } ->
        Scheme.Evaluator.eval(current_total)
      { :ok, :recur }    ->
        IO.gets("")  |> process(current_total)
    end
  end

  def clean(str) do
    String.replace str, "\n", "\n "
  end

  def what_to_do(latest, total) do
    cond do
      is_leading_comment?(latest) ->
        { :ok, :ignore }
      is_only_whitespace?(total) ->
        { :ok, :ignore }
      is_non_list?(total) ->
        { :ok, :evaluate }
      is_balanced?(total) ->
        { :ok, :evaluate }
      has_more_left_parens?(total) ->
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

  defp is_leading_comment?(str) do
    String.match? str, ~r/^\s*;/
  end

  defp has_more_left_parens?(str) do
    num_left_parens(str) > num_right_parens(str)
  end

  defp is_balanced?(str) do
    num_left_parens(str) == num_right_parens(str)
  end

  defp is_non_list?(str) do
    num_left_parens(str) == 0 &&
      num_right_parens(str) == 0
  end

  defp is_only_whitespace?(str), do: String.match?(str, ~r/^\s+$/)

  defp count_num_char(str, char) do
    Enum.filter(to_char_list(str), fn (e) -> e == char end) |> length
  end
end
