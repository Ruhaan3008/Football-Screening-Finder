#lang racket

(require "db-interface.rkt")
(require "backend-db.rkt")

(define host-menus (lambda (host-session)
    (displayln "Enter the number for what you want to do:")
    (displayln "1. View my listings")
    (displayln "2. Add new listings")
    (displayln "3. Edit existing listings")
    (displayln "4. Quit")

    (define user-input (string-trim (read-line)))

    (cond
        ((equal? "1" user-input) (print-host-listings host-session))
        ((equal? "2" user-input) 
            (displayln "Please enter the match id for the new listing.")
            (print-all-matches)
            (displayln "")

            (display "Enter Match ID: ")
            (define new-match-id (string->number (string-trim (read-line))))

            (displayln "Enter Location: ")
            (define new-location (string-trim (read-line)))

            (displayln "Enter Seat Price: ")
            (define new-seat-price (string->number (string-trim (read-line))))

            (displayln "Enter Status:")
            (define new-status (string-trim (read-line)))

            (add-listing new-match-id (session-user-id host-session) new-location new-seat-price new-status)
            (displayln "Listing Created")
            
        )
    )

    (cond
        ((equal? "4" user-input) (displayln "Thank you for your time, you are being logged out."))
        (#t (host-menus host-session))
    )
))

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
    (#t 
        (displayln "You are logged in as a host.")
        (host-menus current-session)
    )
)

))