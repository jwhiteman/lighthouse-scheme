;; basic list helpers
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
      ((fun (car col))
       (cons (car col)
             (filter fun (cdr col))))
      (else
        (filter fun (cdr col))))))

(define concat
  (lambda (l r)
    (cond
      ((null? l) r)
      (else
        (cons (car l)
              (concat (cdr l) r))))))

(define take
  (lambda (n l)
    (cond
      ((zero? n) '())
      (else
        (cons (car l)
              (take (sub1 n)
                    (cdr l)))))))

(define drop
  (lambda (n l)
    (cond
      ((zero? n) l)
      (else
        (drop (sub1 n) (cdr l))))))

(define reverse
  (lambda (l)
    (reverse-helper '() l)))

(define reverse-helper
  (lambda (acc l)
    (cond
      ((null? l) acc)
      (else
        (reverse-helper (cons (car l) acc)
                        (cdr l))))))
