(require "test")

(test "map"
      (lambda ()
        (assert_equal (map add1 '(1 2 3))
                      '(2 3 4))))
