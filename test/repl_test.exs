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
    assert reader(@empty, "42") == { :ok, :evaluate }
  end

  test "balanced lists are evaluated immediately" do
    assert reader(@empty, "(1 (2) 3)") == { :ok , :evaluate }
  end

  test "lists with more left parens recur" do
    assert reader(@empty, "(define rember") == { :ok, :recur }
  end

  test "lists with more right parens are an error" do
    assert reader(@empty, "(define rember))") == { :error, :unexpected_list_terminator }
  end

  test "lists with leading comments are ignored" do
    assert reader("   ;; this is a comment!\n", @empty) == { :ok, :ignore }
  end

end
