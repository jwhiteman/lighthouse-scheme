(define fold
  (lambda (fun acc col)
    (cond
      ((null? col) acc)
      (else
        (fold fun
              (fun (car col) acc)
              (cdr col))))))

(define map
  (lambda (fun col)
    (cond
      ((null? col) '())
      (else
        (cons (fun (car col))
              (map fun (cdr col)))))))

(define filter
  (lambda (fun col)
    (cond
      ((null? col) '())
      ((func (car col))
       (cons (car col)
             (filter fun (cdr col))))
      (else
        (filter fun (cdr col))))))
