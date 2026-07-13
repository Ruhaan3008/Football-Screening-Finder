#lang racket

;;all the structs
(provide 
    (struct-out match)
    (struct-out user)
    (struct-out listing)
    (struct-out booking)
)

;;db related
(provide stadiums teams users bookings)

(provide add-user)

;;listings
(provide null-listing listings)


;;These are vector as sets do not garruntee the order
;;Index in vector is their id

;;use list-ref
(define stadiums (list "New York" "Dallas" "Toronto" "Mexico City"))

(define teams (list "Argentina" "England" "USA" "Scotland" "France" "Netherlands"))

(struct match (home away stadium date) #:mutable)


(struct user (username password is-fan) #:mutable)

(define users (list (user "john" "1234" #t) (user "Kevin" "test" #f)))

(define add-user (lambda (user-name password is-fan)
    (set! users (append users (list (user user-name password is-fan))))
))

(struct listing (match-id user-id location seat-price capacity vacancies) #:mutable)

(define null-listing (listing -1 -1 "" 0 0 0))

;;resize the list every time it grows....
(define listings (vector))


(struct booking (user-id listing-id seats))

;;this can be a set
;;bookings dont need a id
;;will just do a lookup everysingle time
(define bookings (set))