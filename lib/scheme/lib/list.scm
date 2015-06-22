;; fold
(define fold
  (lambda (col acc fun)
    (cond
      ((null? col) acc)
      (else
        (fold (cdr col)
              (fun (car col) acc)
              fun)))))

;; map
(define map
  (lambda (col func)
    (cond
      ((null? col) '())
      (else
        (cons (func (car col))
              (map (cdr col) func))))))

;; filter
(define filter
  (lambda (col func)
    (cond
      ((null? col) '())
      ((func (car col))
       (cons (car col)
             (filter (cdr col) func)))
      (else
        (filter (cdr col) func)))))
