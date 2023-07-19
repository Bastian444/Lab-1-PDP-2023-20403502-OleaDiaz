#lang racket
;; FUNCION DATESYS
;; IMPLEMENTACION =  DECLARATIVA, USO DE LISTA, USO DE FUNCION DEL SISTEMA
;; DOMINIO = TIEMPO(CURRENT-SECONDS)
;; RECORRIDO = LISTA DE VALORES QUE INDICAN UN "TIMESTAMP"
;; RECURSION = N/A
;; DESCRIPCION: LA INTENCION AQUI ES LOGRAR UNA REPRESENTACION DE LA FECHA MAS AMIGABLE
;; PARA QUIEN HAGA USO DE ESTE PROGRAMA. LA IDEA DE TIMESTAMP(MARCA TEMPORAL) ES UN
;; CONCEPTO QUE SERA REQUERIDO DURANTE TODO ESTE PROYECTO.
(provide (all-defined-out))

(define datesys
  (lambda (time)
    (string-append
     (number->string (date-day (seconds->date time)))
     "/"
     (number->string (date-month (seconds->date time)))
     "/"
     (number->string (date-year (seconds->date time)))
     " "
     (number->string (date-hour (seconds->date time)))
     ":"
     (number->string (date-minute (seconds->date time))))))

