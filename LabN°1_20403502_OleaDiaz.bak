#lang racket
;; LABORATORIO N°1 PARADIGMAS DE PROGRAMACION (1-2023)
;; (NO SE HACE USO DE TILDES CON LA INTECION DE NO TENER PROBLEMAS TECNICOS)

;; PARADIGMA: FUNCIONAL | LENGUAJE DE PROGRAMACIÓN: SCHEME/RACKET 
;; POR: BASTIAN OLEA DIAZ

;; REQUERIMIENTO FUNCIONAL N°1:
;; TDA´S (TIPOS DE DATO ABSTRACTOS)

;; TDA SYSTEM, TAMBIEN CONSTRUCTOR (REQUERIMIENTO FUNCIONAL N°2)
;; IMPLEMENTACION = USUARIO LOGEADO(LIST) X NOMBRE(STRING) X FECHA DE CREACION(LIST) X DRIVE(LISTA DE CHAR) X USUARIOS(LIST DE USER)
;; DOMINIO = NOMBRE DEL SISTEMA
;; RECORRIDO = SYSTEM
;; RECURSION = N/A
;; DESCRIPCION = OBTIENE UN NOMBRE Y DEVUELVE UN SYSTEM

(define system (lambda (name)
                 (if (string? name)
                     (list null name (datesys current-seconds) null null)
                     (list null))))

;; TDA DRIVE
;; IMPLEMENTACION = LETRA(CHAR) X NOMBRE(STRING) X USUARIOS(LIST DE USER) X DATOS/CONTENIDO(FOLDERS/FILES)
;; DOMINIO = LETRA, NOMBRE, CAPACIDAD
;; RECORRIDO = DRIVE
;; RECURSION = N/A
;; DESCRIPCION = FUNCION QUE POSTERIORMENTE SERA USADA PARA GENERAR UN DRIVE EN EL SISTEMA

(define drive(lambda(letter name capacity . data)
               (if (and
                   (char? letter)
                   (string? name)
                   (number? capacity))
                   (list letter name capacity)
                   (list null))))

;; TDA DIRECTORY
;; IMPLEMENTACION = NOMBRE(STRING) X DATOS/CONTENIDO(FOLDERS/FILES)
;; DOMINIO = NOMBRE
;; RECORRIDO = DIRECTORIO
;; RECURSION = N/A
;; DESCRIPCION = FUNCION QUE POSTERIORMENTE SE UTILIZARÁ PARA GENERAR UN DIRECTORIO EN EL DRIVE

(define directory(lambda(name . data)
                (if (string? name)
                    (list name)
                    (list null))))

;; TDA FILE
;; IMPLEMENTACION = NOMBRE(STRING) X TIPO/EXTENSIÓN(STRING) X CONTENIDO(STRING)
;; DOMINIO = NOMBRE, TIPO, CONTENIDO
;; RECORRIDO = FILE
;; RECURSION = N/A
;; DESCRIPCION = FUNCION QUE POSTERIORMENTE SE UTILIZARA PARA GENERAR UN FILE

(define file(lambda(name type content)
              (if (and
                  (string? name)
                  (string? type)
                  (string? content))
                  (list name type content)
                  (list null))))

;; TDA USER
;; IMPLEMENTACION = NOMBRE(STRING)
;; DOMINIO = NOMBRE
;; RECORRIDO = USER
;; RECURSION = N/A
;; DESCRIPCION = FUNCION QUE GENERA UN USER

(define user(lambda(name)
                (if (string? name)
                    (list name)
                    (list null))))

;; FUNCIONES UTILES:
;; EN ESTA PARTE SE PRESENTA UN GRUPO DE FUNCIONES NO REQUERIDAS EN EL ENUNCIADO OFICIAL
;; CREADAS CON EL PROPOSITO DE LOGRAR DE MEJOR MANERA LOS DIVERSOS OBJETIVOS. EN ALGUNOS
;; CASOS ESTAS REPRESENTARAN UNA OPTIMIZACION PARA EL PROYECTO.

;; FUNCION DATESYS
;; DESCRIPCION: LA INTENCION AQUI ES LOGRAR UNA REPRESENTACION DE LA FECHA MAS AMIGABLE
;; PARA QUIEN HAGA USO DE ESTE PROGRAMA. LA IDEA DE TIMESTAMP(MARCA TEMPORAL) ES UN
;; CONCEPTO QUE SERA REQUERIDO DURANTE TODO ESTE PROYECTO.

(define datesys
  (lambda(time)
    (list (date-day(seconds->date(time)))
          (date-month(seconds->date(time)))
          (date-year(seconds->date(time)))
          (date-hour(seconds->date(time)))
          (date-minute(seconds->date(time))))))


