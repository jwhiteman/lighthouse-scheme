defmodule ReaderTest do
  use ExUnit.Case

  import Scheme.Reader

  test "count left parens" do
    assert num_left_parens("foo") == 0
    assert num_left_parens("()") == 1
    assert num_left_parens("(1 2 ((3)))") == 3
  end

  test "count num right parans" do
    assert num_right_parens("foo") == 0
    assert num_right_parens("()") == 1
    assert num_right_parens("(1 2 ((3)))") == 3
  end

  test "clean strips lines of pure whitespace" do
    str = """
    \n
    \n
    \t     \t   \n
    """

    assert (str |> clean) == ""
  end

  test "empty strings are ignored" do
    assert reader("") == { :ok, :ignore }
  end

  test "non-lists are evaluated immediately" do
    assert reader("42") == { :ok, :evaluate }
  end

  test "balanced lists are evaluated immediately" do
    assert reader("(1 (2) 3)") == { :ok , :evaluate }
  end

  test "lists with more left parens recur" do
    assert reader("(define rember") == { :ok, :recur }
  end

  test "lists with more right parens are an error" do
    assert reader"(define rember))" == { :error, :unexpected_list_terminator }
  end

end
