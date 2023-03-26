#lang racket
; Requerimientos funcionales 1
; TDAs (Tipos de datos abstractos)


(define system (lambda (name . data)
                 (if (string? name)
                     (list (list "01 03 23 12:00") name)
                     (list null))))

(define drive(lambda(letter name capacity . data)
               (if (and
                   (char? letter)
                   (string? name)
                   (number? capacity))
                   (list letter name capacity)
                   (list null))))

(define folder(lambda(name . data)
                (if (string? name)
                    (list name)
                    (list null))))

(define file(lambda(name type content size)
              (if (and
                  (string? name)
                  (string? type)
                  (string? content)
                  (number? size))
                  (list name type content size)
                  (list null))))

(define user(lambda(name)
                (if (string? name)
                    (list name)
                    (list null))))