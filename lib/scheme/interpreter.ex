defmodule Scheme.Interpreter do

  import Scheme.DefinitionTable, only: [ put: 2, get: 1]

  def build(s1, s2), do: [s1 | [s2 | []]]

  def new_entry(l, r), do: build(l, r)
  def extend_table(e, table), do: [e | table]

  def lookup_in_entry(name, [keys, values], error_function) do
    lookup_in_entry_help(name, keys, values, error_function)
  end

  defp lookup_in_entry_help(name, [], _, error_function) do
    error_function.(name)
  end

  defp lookup_in_entry_help(name, [name|_], [value|_], _) do
    value
  end

  defp lookup_in_entry_help(name, [_|keys], [_|values], error_function) do
    lookup_in_entry_help(name, keys, values, error_function)
  end

  def lookup_in_table(name, [], table_f), do: table_f.(name)
  def lookup_in_table(name, [entry|rest_of_table], table_f) do
    lookup_in_entry(
      name,
      entry,
      fn (n) -> lookup_in_table(n, rest_of_table, table_f) end
    )
  end

  def const_action(n, _) when is_number(n), do: n
  def const_action(b, _) when is_boolean(b), do: b
  def const_action(p, _), do: [:primitive, p]

  def quote_action([_label, body], _), do: body

  def identifier_action(e, table) do
    lookup_in_table(e, table, &lookup_definition/1)
  end

  def lookup_definition(name) do
    case get(name) do
      nil  -> raise "identifier #{name} not found"
      body -> body
    end
  end

  def lambda_action([_type, formals, body], table) do
    [:non_primitive, [table, formals, body]]
  end

  def define_action([_type, name, lambda], _table) do
    put name, lambda_action(lambda, [])
  end

  def atom_to_action(n) when is_number(n) do
    &Scheme.Interpreter.const_action/2
  end

  def atom_to_action(e) do
    case is_member(e, primitives) do
      true  -> &Scheme.Interpreter.const_action/2
      false -> &Scheme.Interpreter.identifier_action/2
    end
  end

  def list_to_action([:quote|_]), do: &Scheme.Interpreter.quote_action/2
  def list_to_action([:lambda|_]), do: &Scheme.Interpreter.lambda_action/2
  def list_to_action([:cond|_]), do: &Scheme.Interpreter.cond_action/2
  def list_to_action([:define|_]), do: &Scheme.Interpreter.define_action/2
  def list_to_action(_) do
    &Scheme.Interpreter.application_action/2
  end

  def expression_to_action(e = [_|_]), do: list_to_action(e)
  def expression_to_action(e), do: atom_to_action(e)

  def meaning(e, table), do: expression_to_action(e).(e, table)

  def cond_action([_ | cond_lines], table), do: evcon(cond_lines, table)

  defp evcon([[:else, answer]], table), do: meaning(answer, table)

  defp evcon([[question, answer] | remaining_questions], table) do
    case meaning(question, table) do
      true  -> meaning(answer, table)
      false -> evcon(remaining_questions, table)
    end
  end
  defp evcon([], _), do: raise "error: no true questions found."

  def evlis([], _), do: []
  def evlis([h|t], table) do
    [meaning(h, table) | evlis(t, table)]
  end

  def apply_primitive(:eq?, [v, v]), do: true
  def apply_primitive(:eq?, [_, _]), do: false
  def apply_primitive(:cons, [l, r]), do: [l|r]
  def apply_primitive(:car, [[h|_] | _]), do: h
  def apply_primitive(:cdr, [[_|t] | _]), do: t
  def apply_primitive(:null?, [[] | _]), do: true
  def apply_primitive(:null?, _), do: false
  def apply_primitive(:atom?, [n]), do: is_atom(n) || is_number(n)
  def apply_primitive(:zero?, [0]), do: true
  def apply_primitive(:zero?, _), do: false
  def apply_primitive(:add1, [n]), do: n + 1
  def apply_primitive(:sub1, [n]), do: n - 1
  def apply_primitive(:number?, [n]), do: is_number(n)
  def apply_primitive(:*, tail) do
    List.foldl tail, 1, &(&1 * &2)
  end

  def apply_primitive(:+, tail) do
    List.foldl tail, 0, &(&1 + &2)
  end

  def apply_primitive(n, _) do
    raise "error: no primitive matches #{n}"
  end

  def appli([:primitive, fun_rep], vals) do
    apply_primitive(fun_rep, vals)
  end

  def appli([:non_primitive, fun_rep], vals) do
    apply_closure(fun_rep, vals)
  end

  def application_action([func | args], table) do
    appli(
      meaning(func, table),
      evlis(args, table)
    )
  end

  def apply_closure([table, formals, body], vals) do
    meaning(body, [[formals, vals] | table])
  end

  def value(e), do: meaning(e, [])

  defp primitives do
    [
      true, false, :cons,
      :car, :cdr, :null?,
      :eq?, :atom?, :zero?,
      :add1, :sub1, :number?,
      :*, :+
    ]
  end

  defp is_member(_, []), do: false
  defp is_member(a, [a|_]), do: true
  defp is_member(a, [_|t]), do: is_member(a, t)

end
