#lang racket
;; REQUERIMIENTO FUNCIONAL N°1:
;; TDA'S (TIPOS DE DATO ABSTRACTOS)

;; TDA DIRECTORY
;; IMPLEMENTACION = DECLARATIVA, USO DE LISTA
;; DOMINIO = NOMBRE, DRIVE, USUARIO, SYSTEM
;; RECORRIDO = DIRECTORIO
;; RECURSION = N/A
;; DESCRIPCION = FUNCION QUE POSTERIORMENTE SE UTILIZARÁ PARA GENERAR UN DIRECTORIO.
(require (file "datesys_20403502_OleaDiaz.rkt"))
(require (file "system_20403502_OleaDiaz.rkt"))
(require (file "user_20403502_OleaDiaz.rkt"))

(define (directory name drive usuario system)
  (if (and
       (string? name)
       (char? drive)
       (user usuario))
      (list drive (if(not(or(char?(string-ref(car(get-system-current-path system))0))(equal?(string-length(get-system-current-path system))3)))
                     (dir-name-maker name drive)
                     (dir-name-maker-subdir name drive (car(get-system-current-path system)))) (datesys (current-seconds)) usuario)
      #f))

;; DIR-NAME-MAKER & DIR-NAME-MAKER
;; IMPLEMENTACION =  DECLARATIVA, MANIPULACION DE STRINGS
;; DOMINIO = NOMBRE(STRING) X DRIVE(USER)
;; RECORRIDO = PATH
;; RECURSION = N/A
;; DESCRIPCION = GENERA UIN PATH QUE SERÁ AGREGADO LUEGO CON TODOS LOS PATH EXISTENTES. UN FUNCION APLICA
;; PARA DIRECTORIOS QUE ESTAN EN DIRECTOS EN LA RAIZ DE UN DRIVE Y EL OTRO (DIR-NAME-MAKER-SUBDIR) SE USA
;; PARA DIRECTORIOS QUE ESTEN CONTENIDOS EN OTROS DIRECTORIOS.

(define (dir-name-maker name drive)
  (string-append (string drive) ":/" name "/"))

(define (dir-name-maker-subdir name drive subdir)
  (string-append (string-append(string drive)"/") (substring subdir 1(string-length subdir))  name "/"))

(provide (all-defined-out))