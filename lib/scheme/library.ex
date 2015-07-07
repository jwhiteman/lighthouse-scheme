defmodule Scheme.Library do
  @libs_directory "lib/scheme/lib"
  @master "library"

  def load do
    load("#{@libs_directory}/#{@master}.scm")
  end

  def load(filename) do
    {:ok, body} = read(filename)

    Scheme.Evaluator.eval(body)

    :ok
  end

  def read(filename) do
    case look_in_standard_lib?(filename) do
      true  -> File.read("#{@libs_directory}/#{filename}.scm")
      false -> File.read(filename)
    end
  end

  def look_in_standard_lib?(filename) do
    String.match?(filename, ~r/^[^\/]+(?<!\.scm)$/)
  end
end
