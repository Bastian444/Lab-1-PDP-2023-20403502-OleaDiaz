#lang racket
;; REQUERIMIENTO FUNCIONAL N°1:
;; TDA'S (TIPOS DE DATO ABSTRACTOS)

;; TDA DRIVE
;; IMPLEMENTACION = DECLARATIVA, USO DE LISTA
;; DOMINIO = LETRA, NOMBRE, CAPACIDAD
;; RECORRIDO = DRIVE
;; RECURSION = N/A
;; DESCRIPCION = FUNCION QUE POSTERIORMENTE SERA USADA PARA GENERAR UN DRIVE EN EL SISTEMA

(define drive(lambda(letter name capacity)
               (if (and
                   (char? letter)
                   (string? name)
                   (number? capacity))
                   (list letter name capacity)
                   #f)))

(provide (all-defined-out))