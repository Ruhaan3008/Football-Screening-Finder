#lang racket

(require "backend-db.rkt")

(define get-teams (lambda () teams))
(define get-stadiums (lambda () stadiums))

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

(define get-users (lambda () users))
(define get-user (lambda (x) (list-ref users x)))

(struct session (user-id is-validated) #:mutable)

(define log-in (lambda (username password)
  (define isValid #f)
  (define id -1)

  (define index 0)

  (for ([i (length (get-users))])

    (cond
      ((and (equal? (user-username (get-user i)) username)
            (equal? (user-password (get-user i)) password)
              (set! isValid (or isValid #t))
              (set! id index)))
      (#t (set! index (+ index 1)))
      )
  )

  ;; I dont understand racket return semantics 
  ;; returns
  (session id isValid)))

(define valid-session? (lambda (x)
  (session-is-validated x)
))