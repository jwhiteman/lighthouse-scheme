(require "test")

;; helper
(define greater_than_two (lambda (n) (> n 2)))

(test "map"
      (lambda ()
        (assert_equal (map add1 '(1 2 3))
                      '(2 3 4))))

(test "filter"
      (lambda ()
        (assert_equal (filter greater_than_two '(1 2 3 4 5))
                      '(3 4 5))))

(test "fold"
      (lambda ()
        (assert_equal (fold + 0 '(1 2 3))
                      6)))

(test "concat"
      (lambda ()
        (assert_equal (concat '(a b c) '(1 2 3))
                      '(a b c 1 2 3))))

(test "take"
      (lambda ()
        (assert_equal (take 2 '(1 2 3 4 5))
                      '(1 2))))

(test "drop"
      (lambda ()
        (assert_equal (drop 2 '(1 2 3 4 5))
                      '(3 4 5))))

(test "reverse"
      (lambda ()
        (assert_equal (reverse '(1 2 3))
                      '(3 2 1))))
