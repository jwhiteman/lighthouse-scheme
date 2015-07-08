;; basic test framework
(define test
  (lambda (desc assertion)
    (cond
      ((assertion)(test-unit-affirm desc))
      (else (test-unit-deny desc)))))

(define assert
  (lambda (v)
    (eq? #t v)))

(define refute
  (lambda (v)
    (eq? #f v)))

(define assert_equal
  (lambda (l r)
    (assert (eq? l r))))

(define test-unit-affirm
  (lambda (desc)
    (print-result desc "ok")))

(define test-unit-deny
  (lambda (desc)
    (print-result desc "fail")))

(define print-result
  (lambda (desc result)
    (begin
      (display desc)
      (display "...")
      (display result)
      (display ".\n"))))
