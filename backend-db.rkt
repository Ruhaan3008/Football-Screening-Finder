#lang racket

;;all the structs
(provide 
    (struct-out match)
    (struct-out user)
    (struct-out listing)
    (struct-out booking)
)

;;db related
(provide stadiums teams users bookings matches)

(provide add-user)

;;listings
(provide listings matches)


;;These are vector as sets do not garruntee the order
;;Index in vector is their id

;;use list-ref
(define stadiums (list "New York" "Dallas" "Toronto" "Mexico City"))

(define teams (list "Argentina" "England" "USA" "Scotland" "France" "Netherlands"))

(struct match (home away stadium date) #:mutable)

(define matches (list
  (match 0 1 1 "6 July")
  (match 2 4 0 "10 July")
  (match 3 5 2 "9 July")
  (match 0 2 3 "11 July")
))


(struct user (username password is-fan) #:mutable)

(define users (list (user "john" "1234" #t) (user "Kevin" "test" #f)))

(define add-user (lambda (user-name password is-fan)
    (set! users (append users (list (user user-name password is-fan))))
))

(struct listing (match-id user-id location seat-price status) #:mutable)

;;just make it a list, length will change during run time
;;these are for hosts, and only belong to hosts
(define listings (list
    (listing 0 1 "Hendon Central" 20 "Avaliable")
))


(struct booking (user-id listing-id seats))

;;this can be a set
;;bookings dont need a id
;;will just do a lookup everysingle time
(define bookings (set))