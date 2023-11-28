;; step 6

(check-type (if #t 5 6) int)
(check-type (if #f 'noble 'baffy) sym)
(check-type (if #t #f #t) bool)

(check-type-error (if 5 6 7) )
(check-type-error (if 'baffy 6 7))
(check-type-error (if #t 'hi 7) )


;; step 7

(check-type - (int int -> int))
(check-type + (int int -> int))
(check-type null? (forall ['a] ((list 'a) -> bool)))

(check-type-error even? )

;; step 9

(val e1 5)
(val e2 #t)
(val e3 'hi)


(check-type e1 int)
(check-type e2 bool)
(check-type e3 sym)


(check-type-error (val e4 (if 1 #t #f)))
(check-type-error (val e5 (if sym #t #f)))

(check-type-error e6)


;; step 10
(check-type  (/ 2 5)  int)
(check-type  (< -1 9)  bool)
(check-type  (> 3 2)  bool)

(check-type  (+ 4 2)  int)
(check-type  (- 5 4)  int)
(check-type  (* 3 4)  int)

(check-type-error  (* 'x 2))
(check-type-error  (+ 1 2 3))
(check-type-error  (/ 5 0 3))
(check-type-error  (3 4 5))-


;; step 11
(check-type (let ([p 3] [q 13]) (< q p)) bool)
(check-type (let ([x 7] [y 4]) (+ x y)) int)


(check-type-error (let ([x (if 6 'hi 'hello)] [y 67]) (< y x)))
(check-type-error (let ([x error] [y 8]) (< x y)))



(check-type-error (let ([c #t] [d 34]) (> c d)))
(check-type-error (let ([c #t] [d 72]) (- c d)))
(check-type-error (let ([c #f] [d 91]) (+ c d)))



;; step 12
(val a -2)
(val b -1)

(check-type (lambda ([a : int] [b : int]) (< a b)) (int int -> bool))
(check-type (lambda ([a : int] [b : int]) (+ a b)) (int int -> int))
(check-type (lambda ([a : int] [b : int]) (> a b)) (int int -> bool))


(check-type (lambda ([x : int] [y : int]) (+ x y)) (int int -> int))


(check-type-error (lambda ([p : int] [q : boolean]) (+ p q)))
(check-type-error (lambda ([p : boolean] [q : list]) (+ p q)))




;; step 13
(val x 13)
(val y 'hi)
(val z #t)


;; set tests
(check-type (set x 1) int)
(check-type (set y 'hello) sym)
(check-type (set z #f) bool)

(check-type-error (set x #t))
(check-type-error (set y #t))
(check-type-error (set z sym))
(check-type-error (set z int))


;; while tests
(check-type (while (< x 25) (set x (- x 2))) unit)

(check-type-error (while (+ x 14) (set x (+ x 1))))


;;begin tests

(check-type (begin (+ 3 2) (< 8 8) (set y 'hello)) sym)
(check-type (begin ) unit)

(check-type-error (begin (+ 4 6) (< 4 6) (set y 56)))
(check-type-error (begin (+ 'hyy -7) (< 2 6) (set y 'ears)))



;; step 14
(check-type (let* ([x 6] [y 8]) (- y x)) int)
(check-type (let* ([x 5] [y 6]) (< x y)) bool)


(check-type-error (let* ([x #t] [y 3]) (< x y)))
(check-type-error (let* ([x error] [y error]) (> x y)))
(check-type-error (let* ([x error] [y #t]) (+ y x)))
(check-type-error (let* ([x (if 6 'hi #t)] [y error]) (< x y)))


; step 15
(check-type (letrec [
    ([fa : (int int -> int)] (lambda ([x : int] [y : int]) (- x y)))
    ([fb : (int int -> bool)] (lambda ([x : int] [y : int]) (> x y)))]
        (if (fb 4 12) (fa 70 2) (fa -3 4) ))  int)

(check-type-error (letrec [
    ([fa : (int int -> int)] (+ 3 2))
    ([fb : (int int -> bool)] (lambda ([x : int] [y : int]) (> x y)))]
        (if (fb 5 18) (fa 2 19) (f1 12 11))))




;; step 16
(val-rec [fa : (int int -> int)] (lambda ([x : int] [y : int]) (+ x y)) )
(check-type (set x (fa 4 2)) int)

(check-type-error (val-rec [fb : int] -2))
(check-type-error (val-rec [fc : list]
                           (lambda ([x : int] [y : int]) (+ x y))))
(check-type-error (val-rec [fd : int]
                           (lambda ([x : int] [y : int]) (+ x y)) ))

(define int sum ([x : int] [y : int]) (+ x y) )
(check-type (sum 7 3) int)

(check-type-error (define bool product ([x : int] [y : int]) (* x y) ))
(check-type-error (product 4 18))


;; step 17
(check-type (type-lambda ['a] (lambda ([ x : 'a]) x))
            (forall ('a) ('a -> 'a)))

(check-type ([@ cons int] 8 [@ '() int]) (list int))



;; step 18
(check-type '(2 2) (list int))
(check-type '(4) (list int))
(check-type '() (forall ['a] (list 'a)))

(check-type-error '(2 'hi))