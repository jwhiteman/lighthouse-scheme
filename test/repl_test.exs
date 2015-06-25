defmodule REPLTest do
  use ExUnit.Case

  import Scheme.REPL

  @empty ""

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

  test "clean adds a space after newline" do
    assert clean("abc\ndef") == "abc\n def"
  end

  test "non-lists are evaluated immediately" do
    assert what_to_do(@empty, "42") == { :ok, :evaluate }
  end

  test "balanced lists are evaluated immediately" do
    assert what_to_do(@empty, "(1 (2) 3)") == { :ok , :evaluate }
  end

  test "lists with more left parens recur" do
    assert what_to_do(@empty, "(define rember") == { :ok, :recur }
  end

  test "lists with more right parens are an error" do
    assert what_to_do(@empty, "(define rember))") == { :error, :unexpected_list_terminator }
  end

  test "lists with leading comments are ignored" do
    assert what_to_do("   ;; this is a comment!\n", @empty) == { :ok, :ignore }
  end

end
