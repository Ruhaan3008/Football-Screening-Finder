#lang racket

;;all the structs
(provide 
    (struct-out match)
    (struct-out user)
    (struct-out listing)
    (struct-out booking)
)

;;db related
(provide stadiums teams users listings bookings matches)

;;function that need to be defined here
(provide add-user 
  add-listing edit-listing
  delete-booking
)



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
    (listing 2 1 "Hendon Central" 20 "Booking Fast")
))

(define add-listing (lambda (match-id user-id location seat-price status)
  (set! listings (append listings (list (listing match-id user-id location seat-price status))))
))

(define edit-listing
  (lambda (index match-id user-id location seat-price status)
    (set! listings (list-set listings index 
      (listing match-id user-id location seat-price status)
      )
    )
))


(struct booking (user-id listing-id))

;;this needs to be a list, ids are needed for this as well
(define bookings (list
  (booking 0 0)
  (booking 0 1)
))

;;source for remove function
;;https://stackoverflow.com/questions/19913606/delete-element-from-list-in-scheme
(define delete-booking (lambda (index)
  (set! bookings (remove (list-ref bookings index) bookings))
))