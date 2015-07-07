defmodule LibraryTest do
  use ExUnit.Case

  import Scheme.Library

  test "look_in_standard_lib?" do
    assert(look_in_standard_lib?("list"))
    refute(look_in_standard_lib?("list.scm"))
    refute(look_in_standard_lib?("foo/bar/list.scm"))
  end

end
