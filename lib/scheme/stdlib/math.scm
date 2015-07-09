(define =
  (lambda (x y)
    (eq? x y)))

(define <=
  (lambda (x y)
    (or (< x y)
        (= x y))))

(define >=
  (lambda (x y)
    (or (> x y)
        (= x y))))

;; todo: mod
;; todo: divisible?
