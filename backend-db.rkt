#lang racket

;;all the structs
(provide (struct-out match) (struct-out user))

;;db related
(provide venues teams users)


;;These are vector as sets do not garruntee the order
;;Index in vector is their id

;;use list-ref
(define venues (list "New York" "Dallas" "Toronto" "Mexico City"))

(define teams (vector "Argentina" "England" "USA" "Scotland" "France" "Netherlands"))

(struct match (home away stadium date) #:mutable)


(struct user (username password is-fan) #:mutable)

(define users (list (user "john" "1234" #t) (user "Kevin" "test" #f)))