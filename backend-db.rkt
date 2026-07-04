#lang racket

;;all the structs
(provide 
    (struct-out match)
    (struct-out user)
    (struct-out listing)
)

;;db related
(provide stadiums teams users)

;;listings
(provide null-listing listings)


;;These are vector as sets do not garruntee the order
;;Index in vector is their id

;;use list-ref
(define stadiums (list "New York" "Dallas" "Toronto" "Mexico City"))

(define teams (vector "Argentina" "England" "USA" "Scotland" "France" "Netherlands"))

(struct match (home away stadium date) #:mutable)


(struct user (username password is-fan) #:mutable)

(define users (list (user "john" "1234" #t) (user "Kevin" "test" #f)))



(struct listing (match-id user-id location seat-price capacity vacancies) #:mutable)

(define null-listing (listing -1 -1 "" 0 0 0))

;;should this be a set?? cant have duplicate here and order does not matter...
(define listings (set))