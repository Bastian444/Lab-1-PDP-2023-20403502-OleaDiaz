#lang racket
; Requerimientos funcionales 1
; TDAs (Tipos de dato abstracto)


(define system (lambda (name . data)
                 (if (string? name)
                     (list (list "01 03 23 12:00") name)
                     (list null))))