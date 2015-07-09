(require "test")

(test "= when equal"
      (lambda ()
        (assert (= 1 1))))

(test "= when not equal"
      (lambda ()
        (refute (= 1 0))))

(test "<= when less"
      (lambda ()
        (assert (<= 1 2))))

(test "<= when equal"
      (lambda ()
        (assert (<= 2 2))))

(test ">= when greater"
      (lambda ()
        (assert (>= 3 2))))

(test ">= when equal"
      (lambda ()
        (assert (>= 2 2))))
