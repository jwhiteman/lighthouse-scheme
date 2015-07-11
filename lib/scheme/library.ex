defmodule Scheme.Library do
  @libs_directory "lib/scheme/stdlib"
  @master "core"
  @extension "scm"

  def load do
    load("#{@libs_directory}/#{@master}.#{@extension}")
  end

  def load(filename) do
    {:ok, body} = read(filename)

    Scheme.Evaluator.eval(body)

    :ok
  end

  def read(filename) do
    case look_in_standard_lib?(filename) do
      true  -> File.read("#{@libs_directory}/#{filename}.#{@extension}")
      false -> File.read(filename)
    end
  end

  def look_in_standard_lib?(filename) do
    String.match? filename, ~r/
      ^
        [^\/]          # no match if filename has any slashes
        +(?<!\.scm)    # no match if filename ends in .scm
      $
    /x
  end
end
