defmodule Scheme.Printer do
  def print(l) when is_list(l) do
    "(" <> print_helper(l)
  end

  def print(n) when is_number(n), do: to_string(n)
  def print(false), do: "#f"
  def print(true), do: "#t"
  def print(atom) when is_atom(atom), do: to_string(atom)

  def print_helper([]), do: ")"
  def print_helper([h|[]]), do: print(h) <> print_helper([])
  def print_helper([h|t]), do: print(h) <> " " <> print_helper(t)
end