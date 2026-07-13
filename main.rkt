#lang racket

(require "db-interface.rkt")
(require "backend-db.rkt")


(displayln "Welcom to Football Screening Finder")

(display "Would you like to create a new account? (y/n): ")
(cond
    ( (equal? "y" (string-trim (read-line)))
        (display "Choose a username: ")
        (define new-username (string-trim (read-line)))

        (display "Choose a password: ")
        (define new-password (string-trim (read-line)))

        (display "Are you a fan or a host? (f/h): ")
        (define role (string-trim (read-line)))

        (add-user new-username new-password (equal? role "f"))

        (displayln "Account Created.")
    )
)


(display "Enter Your Username: ")
(define username (string-trim (read-line)))

(display "Enter Your Password: ")
(define password (string-trim (read-line)))

(define current-session (log-in username password))

(cond 
    ((not(valid-session? current-session)) (displayln "Log in credentials are wrong."))
    (#t (displayln "Log in successful")

(define is-user-fan (is-user-fan? current-session))

(cond
    (is-user-fan (displayln "You are logged in as a fan."))
    (#t (displayln "You are logged in as a host."))
)

))