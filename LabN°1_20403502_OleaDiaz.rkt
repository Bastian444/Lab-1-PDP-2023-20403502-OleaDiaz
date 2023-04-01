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
                     #f)))

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
                   #f)))

;; TDA DIRECTORY
;; IMPLEMENTACION = NOMBRE(STRING) X DATOS/CONTENIDO(FOLDERS/FILES)
;; DOMINIO = NOMBRE
;; RECORRIDO = DIRECTORIO
;; RECURSION = N/A
;; DESCRIPCION = FUNCION QUE POSTERIORMENTE SE UTILIZARÁ PARA GENERAR UN DIRECTORIO EN EL DRIVE

(define directory(lambda(name . data)
                (if (string? name)
                    (list name)
                    #f)))

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
                  #f)))

;; TDA USER
;; IMPLEMENTACION = NOMBRE(STRING)
;; DOMINIO = NOMBRE
;; RECORRIDO = USER
;; RECURSION = N/A
;; DESCRIPCION = FUNCION QUE GENERA UN USER

(define user(lambda(name)
                (if (string? name)
                    name
                    #f)))

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

;; FUNCION COLLECTOR-LETTER-LST
;; DESCRIPCION: SU FUNCION ES RECOLECTAR LA LETRA DE TODOS LOS DRIVES EXISTENTES PARA
;; PODER IDENTIFICAR SI EL DRIVE QUE SERA INGRESADO YA EXISTE.

(define (collector-letter lst)
  (cond ((null? lst) '())
        ((not (list? (car lst))) '())
        (else (cons (car (car lst))
                    (collector-letter (cdr lst))))))

;; FUNCION EXISTING-DRIVE?
;; DESCRIPCION: COMPARA SI EL DRIVE QUE QUIERE SER INGRESADO EXISTE YA EN LOS DRIVES
;; EXISTENTES.

(define (existing-drive? new-drive drives)
  (if (not (member new-drive drives))
      #f
      (eqv? new-drive (car (filter (lambda (x) (eqv? new-drive x)) drives)))))

;; FUNCION MAKE-SYSTEM:
;; DESCRIPCION: CREA UN SYSTEM

(define (make-system current-user name date users drive)
  (list current-user name date users drive))

;; FUNCION GET-SYSTEM-CURRENT-USER:
(define get-system-current-user car)
;; FUNCION GET-SYSTEM-NAME:
(define get-system-name cadr)
;; FUNCION GET-SYSTEM-DATE:
(define get-system-date caddr)
;; FUNCION GET-SYSTEM-USER:
(define get-system-user cadddr)
;; FUNCION GET-SYSTEM-DRIVE:
(define get-system-drive
  (lambda(system)
    (car(reverse system))))

;; FUNCION MAKE-DRIVE:
(define (make-drive letter name capacity)
  (drive letter name capacity))

;; FUNCION MAKE-USUARIO:
(define (make-user name)
  (user name))

;; REQUERIMIENTO FUNCIONAL N°3:
;; RUN
;; IMPLEMENTACION = USO DE FUNCION DE ORDEN SUPERIOR 
;; DOMINIO = SYSTEM X COMANDO(FUNCION)
;; RECORRIDO = SYSTEM (CON EL COMANDO APLICADO)
;; RECURSION = N/A
;; DESCRIPCION = FUNCION DE ORDEN SUPERIOR QUE RECIBE UN SISTEMA Y UN COMANDO(FUNCION)
;; PARA POSTERIORMENTE APLICAR ESE COMANDO SOBRE EL SISTEMA.

(define (run sys f)
  (f sys))

;; REQUERIMIENTO FUNCIONAL N°4:
;; ADD-DRIVE
;; IMPLEMENTACION = USO DE CURRIFICACION 
;; DOMINIO = SYSTEM X (LETTER(CHAR) X NAME(STRING) X CAPACITY(NUMBER))
;; RECORRIDO =  SYSTEM
;; RECURSION =  N/A
;; DESCRIPCION = FUNCION CURRIFICADA QUE AGREGAR UN DRIVE A UN SISTEMA.

(define add-drive
  (lambda(system)
    (lambda(letter name capacity)
    (if (null?(get-system-drive system))(make-system(get-system-current-user system)
                    (get-system-name system)
                    (get-system-date system)
                    (get-system-user system)
                    (cons (make-drive letter name capacity)(get-system-drive system)))
              (if(existing-drive? letter (collector-letter (get-system-drive system)))
                 #f
                 (make-system(get-system-current-user system)
                    (get-system-name system)
                    (get-system-date system)
                    (get-system-user system)
                    (cons (make-drive letter name capacity)(get-system-drive system))))))))

;; REQUERIMIENTO FUNCIONAL N°5:
;; REGISTER
;; IMPLEMENTACION = FUNCION CURRIFICADA 
;; DOMINIO = SYSTEM X (USER(STRING))
;; RECORRIDO = SYSTEM
;; RECURSION = N/A
;; DESCRIPCION = AGREGA UN USUARIO A EL SISTEMA, ESTE NO PUEDE EXISTIR PREVIAMENTE
;; DE SER ASÍ CREARA UN BOOLEANO FALSO.

(define register
  (lambda(system)
    (lambda(name)
      (if(list?(member name (get-system-user system)))
         #f
         (make-system(get-system-current-user system)
                     (get-system-name system)
                     (get-system-date system)
                     (cons(make-user name)(get-system-user system))
                     (get-system-drive system))))))


;; REQUERIMIENTO FUNCIONAL N°6:
;; LOGIN
;; IMPLEMENTACION = FUNCION CURRIFICADA
;; DOMINIO = SYSTEM X (USER(STRING))
;; RECORRIDO = SYSTEM 
;; RECURSION = N/A
;; DESCRIPCION = INICIA SESION CON EL NOMBRE DE UN USUARIO, ESTE DEBE EXISTIR
;; PREVIAMENTE, SI NO EXISTE PREVIAMENTE ESTE FUNCION CREARA UN #F.

(define login
  (lambda(system)
    (lambda(name)
    (if(list?(member name (get-system-user system)))
       (make-system(cons name(get-system-current-user system))
                     (get-system-name system)
                     (get-system-date system)
                     (get-system-user system)
                     (get-system-drive system))
       #f))))

;; REQUERIMIENTO FUNCIONAL N°7:
;; LOGOUT
;; IMPLEMENTACION = FUNCION CURRIFICADA 
;; DOMINIO = SYSTEM 
;; RECORRIDO = SYSTEM
;; RECURSION = N/A
;; DESCRIPCION = CIERRA SESION DEL USUARIO QUE ESTABA ACTIVO, DE NO HABER
;; INICIADO SESION PREVIAMENTE, EL RESULTADO SERA UN #F.

(define logout
  (lambda(system)
      (if(null? (get-system-current-user system))
         #f
         (make-system null
                     (get-system-name system)
                     (get-system-date system)
                     (get-system-user system)
                     (get-system-drive system)))))

(display "Campo de pruebas: \n")
(define S0(system "Kali Linux"))
(define S1((run S0 add-drive)#\C "Drive1" 2424))
S1
(define S2((run S1 register)"Flash"))
S2
(define S3((run S2 register)"Batman"))
S3
(define S4((run S3 add-drive)#\D "Drive2" 1000))
S4
(display "Error \n")
(define S5((run S4 register)"Robin"))
S5
(define S6((run S5 login)"Batman"))
S6

