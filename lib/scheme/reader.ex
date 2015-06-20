defmodule Scheme.Reader do
  # 1. ignore lines of pure whitespace
  # 2. print non-lists immediately
  # 3. if the number of ( equal the number of ), then print
  # 4. if the number of ( are greater than ), then recur until they do
  # 5. if the number of ( is less than ), then raise an error.
  # you'll need an accumulator, because for any given line '(' and ')' may be uneven.
  # ...so you'll need to run the tests against the accumulator <> new-content.

  @lparen 40
  @rparen 41

  def read do
    IO.gets("# ") |> String.strip |> IO.puts

    read
  end

  def clean(str) do
    String.strip str
  end

  def reader(str) do
    cond do
      is_empty_string(str) ->
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

  defp is_empty_string(""), do: true
  defp is_empty_string(_), do: false

  defp count_num_char(str, char) do
    Enum.filter(to_char_list(str), fn (e) -> e == char end) |> length
  end
end
