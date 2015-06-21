defmodule PrinterTest do
  use ExUnit.Case

  import Scheme.Printer

  test "printing numbers" do
    assert print(1) == "1"
  end

  test "print false" do
    assert print(false) == "#f"
  end

  test "print true" do
    assert print(true) == "#t"
  end

  test "prints atoms" do
    assert print(:define) == "define"
  end

  test "prints an empty list" do
    assert print([]) == "()"
  end

  test "prints a list with 1 element" do
    assert print([1]) == "(1)"
  end

  test "prints a list with multiple elements" do
    assert print([1, 2, 3]) == "(1 2 3)"
  end

  test "prints a list with nested lists" do
    assert print([1, [2], 3]) == "(1 (2) 3)"

    assert print(
      [[[3]]]
    ) == "(((3)))"

    assert print(
      [:define, :rember,
        [:lambda, [:a, :lat],
          [:cond,
            [[:null?, :lat], [:quote, []]],
            [[:eq?, [:car, :lat], :a],
              [:rember, :a, [:cdr, :lat]]],
            [:else,
              [:cons, [:car, :lat],
                [:rember, :a, [:cdr, :lat]]]]]]]
    ) == "(define rember (lambda (a lat) (cond ((null? lat) (quote ())) ((eq? (car lat) a) (rember a (cdr lat))) (else (cons (car lat) (rember a (cdr lat)))))))"
  end

  test "integration: evaluator with printer" do
    Scheme.DefinitionTable.start_link

    result = Scheme.Evaluator.eval """
    (define rember
      (lambda (a lat)
        (cond
          ((null? lat) (quote ()))
          ((eq? (car lat) a)
           (rember a (cdr lat)))
          (else
            (cons (car lat)
              (rember a (cdr lat)))))))
 
    (rember (quote c) (quote (a c d c e c)))
    """

    assert print(result) == "(a d e)"
  end

end
