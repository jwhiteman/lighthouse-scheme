defmodule ParserTest do
  use ExUnit.Case

  import Scheme.Parser

  test "a single element" do
    assert parse("1") == [1]
  end

  test "multiple elements" do
    assert parse("1 1 1") == [1, 1, 1]
  end

  test "elements with lists" do
    assert parse("1 (add1 1) 1 (add1 1)") == [1, [:add1, 1], 1, [:add1, 1]]
    assert parse("1 1 1 (add1 1) 1 1 (add1 1) 1 1") == 
      [1, 1, 1, [:add1, 1], 1, 1, [:add1, 1], 1, 1]
  end

  test "elements with complex lists" do
    assert parse("1 1 1 ((lambda (x) (add1 x)) 42) 1 1") ==
      [1, 1, 1, [[:lambda, [:x], [:add1, :x]], 42], 1, 1]
  end

  test "an empty list" do
    assert parse("()") == [[]]
  end

  test "a list" do
    assert parse("(+ 1 2 3)") == [[:+, 1, 2, 3]]
  end

  test "booleans" do
    [[:else, true]] = parse("(else #t)")
    [[:else, false]] = parse("(else #f)")
  end

  test "atoms with integers" do
    assert parse("(add1 x)") == [[:add1, :x]]
  end

  test "a complex list" do
    assert parse("""
    (define rember
      (lambda (a lat)
        (cond
          ((null? l) (quote ()))
          ((eq? (car lat) a)
           (cdr lat))
          (else
            (cons (car lat)
              (rember a (cdr lat)))))))
    """) == [[:define, :rember,
              [:lambda, [:a, :lat],
                [:cond,
                  [[:null?, :l], [:quote, []]],
                  [[:eq?, [:car, :lat], :a],
                    [:cdr, :lat]],
                  [:else,
                    [:cons, [:car, :lat],
                      [:rember, :a, [:cdr, :lat]]]]]]]]
  end
end
