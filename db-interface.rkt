#lang racket

(require "backend-db.rkt")

(provide (struct-out session))
(provide log-in valid-session? is-user-fan? 
  print-listing print-host-listings
  print-all-matches
)

;;just made thsi seperate to keep things clean
(provide get-team get-venue)

(define get-teams (lambda () teams))
(define get-stadiums (lambda () stadiums))

(define get-team (lambda (x) (list-ref (get-teams) x)))
(define get-match (lambda (x) (list-ref matches x)))
(define get-venue (lambda (x) (list-ref (get-stadiums) x)))

(define get-id-internal (lambda (x lst)
    (define ret-index -1)
    (define index 0)
    (for ([i lst])
        (cond
            ((equal? i x) (set! ret-index  index))
            (#t (set! index (+ index 1)))
        )
    )

    ;;this should be the value that returns
    ret-index
))

(define get-team-id (lambda (x) (get-id-internal x teams)))

(define get-venue-id (lambda (x) (get-id-internal x stadiums)))

(define print-match (lambda (m)
  (display (get-team (match-home m)))
  (display " vs ")
  (display (get-team (match-away m)))
  (display " played at ")
  (display (get-venue (match-stadium m)))
  (display " on ")
  (displayln (match-date m))
))

(define print-all-matches (lambda ()

  (for ([id (in-range (length matches))])
    (display "Match ID: ")
    (displayln id)
    (print-match (get-match id))
  )
))

(define get-users (lambda () users))
(define get-user (lambda (x) (list-ref users x)))

(struct session (user-id is-validated) #:mutable)

(define log-in (lambda (username password)
  (define isValid #f)
  (define id -1)

  (for ([i (length (get-users))])
    (cond 
      ((and 
        (equal? (user-username (get-user i)) username)
        (equal? (user-password (get-user i)) password))

        (set! isValid #t)
        (set! id i)
      ))
    )

  ;;returns
  (session id isValid)
))

(define valid-session? (lambda (x)
  (session-is-validated x)
))

(define valid-listing? (lambda (x) 
  (equal? -1 (listing-match-id x))
))

(define print-host-listings (lambda (host-session)
  (define user-id (session-user-id host-session))

  (for ([id (in-range (length listings))])
    (define l (list-ref listings id))

    (cond
      ((equal? (listing-user-id l) user-id) 
        (display "Listing id: ")
        (displayln id)
        (print-listing l)
      )
      (#t (void))
    )
  )
))

(define print-listing (lambda (l)
  (display "Match: ")
  (print-match (get-match (listing-match-id l)))

  (display "Location: ")
  (displayln (listing-location l))

  (display "Price: $")
  (displayln (listing-seat-price l))

  (display "Capacity: ")
  (displayln (listing-status l))
))

(define is-user-fan? (lambda (x)
  (user-is-fan (get-user (session-user-id x)))
))

;;(define add-listing (lambda (x)
  ;;(set! listings (vector-append listings x))
;;))