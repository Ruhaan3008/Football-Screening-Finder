#lang racket

(require "backend-db.rkt")

(define get-teams (lambda () teams))
(define get-venues (lambda () venues))
(define get-users (lambda () users))
(define get-user (lambda (x) (list-ref users x)))

(struct session (user-id is-validated) #:mutable)

(define log-in (lambda (username password)
                 (define isValid #f)
                 (define id -1)
                 (define index 0)
                 (for ([i (length (get-users))])

                   (cond
                     (
                      (and (equal? (user-username (get-user i)) username)
                           (equal? (user-password (get-user i)) password)
                           (set! isValid (or isValid #t))
                           (set! id index))
                      )
                     (#t (set! index (+ index 1)))
                     ))
                 ;; I dont understand racket return semantics 
                 ;; returns
                 (session id isValid)))