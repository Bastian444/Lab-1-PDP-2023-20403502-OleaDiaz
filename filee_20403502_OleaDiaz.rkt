#lang racket
;; REQUERIMIENTO FUNCIONAL N°1:
;; TDA'S (TIPOS DE DATO ABSTRACTOS)

;; TDA FILE
;; IMPLEMENTACION = DECLARATIVA, USO DE LISTA
;; DOMINIO = NOMBRE, TIPO, CONTENIDO
;; RECORRIDO = FILE
;; RECURSION = N/A
;; DESCRIPCION = FUNCION QUE POSTERIORMENTE SE UTILIZARA PARA GENERAR UN FILE
(require (file "datesys_20403502_OleaDiaz.rkt"))

(define filee(lambda(name ext content)
              (if (and
                  (string? name)
                  (string? ext)
                  (string? content))
                  (list name ext content)
                  #f)))

;; FILE-NAME-MAKER 
;; IMPLEMENTACION = DECLARATIVA, MANIPULACION STRING 
;; DOMINIO = NOMBRE, TIPO, DRIVE, ACTUAL RUTA
;; RECORRIDO = NOMBRE DE UN FILE (STRING)
;; RECURSION = N/A
;; DESCRIPCION = A PARTIR DE LOS COMPONENTES DEFINIDOS EN DOMINIO CREA UN NOMBRE.
;; EJEMPLO: "C:/FOLDER/TEXTO.pdf"

(define (file-name-maker name ext drive current-dir)
  (string-append (string drive) (substring current-dir 1(string-length current-dir)) name ext))

;; FILE-PATH
;; IMPLEMENTACION = DECLARATIVA MANIPULACION STRING
;; DOMINIO = DRIVE,RUTA, FILE, TIPO, USUARIO
;; RECORRIDO = RUTA(STRING)
;; RECURSION = N/A
;; DESCRIPCION = GENERA UNA RUTA QUE SE AÑADIRA A LAS YA EXISTENTES TOMANDO EL ARCHIVO COMO
;; UNA DE SUS ENTRADAS.

(define file-path(lambda(drive path filee ext user)
                   (list drive path filee ext (datesys (current-seconds)) user)))

(provide (all-defined-out))