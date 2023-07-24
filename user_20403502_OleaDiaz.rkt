#lang racket
;; REQUERIMIENTO FUNCIONAL N°1:
;; TDA'S (TIPOS DE DATO ABSTRACTOS)

;; TDA USER
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = NOMBRE
;; RECORRIDO = USER
;; RECURSION = N/A
;; DESCRIPCION = FUNCION QUE GENERA UN USER

(define user(lambda(name)
                (if (string? name)
                    name
                    #f)))

(provide(all-defined-out))