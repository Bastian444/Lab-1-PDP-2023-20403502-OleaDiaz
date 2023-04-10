#lang racket
;; LABORATORIO N°1 PARADIGMAS DE PROGRAMACION (1-2023)
;; (NO SE HACE USO DE TILDES CON LA INTECION DE NO TENER PROBLEMAS TECNICOS)

;; PARADIGMA: FUNCIONAL | LENGUAJE DE PROGRAMACIÓN: SCHEME/RACKET 
;; POR: BASTIAN OLEA DIAZ

;; REQUERIMIENTO FUNCIONAL N°1:
;; TDA´S (TIPOS DE DATO ABSTRACTOS)

;; TDA SYSTEM, TAMBIEN CONSTRUCTOR (REQUERIMIENTO FUNCIONAL N°2)
;; IMPLEMENTACION = USUARIO LOGEADO(LIST) X NOMBRE(STRING) X FECHA DE CREACION(LIST) X USUARIOS(LIST DE USER) X DRIVE(LISTA DE CHAR) X DRIVE EN USO (CHAR) X CURRENT-PATH (STRING) X RUTAS (LISTA DE RUTAS)
;; DOMINIO = NOMBRE DEL SISTEMA
;; RECORRIDO = SYSTEM
;; RECURSION = N/A
;; DESCRIPCION = OBTIENE UN NOMBRE Y DEVUELVE UN SYSTEM

(define system (lambda (name)
                 (if (string? name)
                     (list null name (datesys current-seconds) null null null null null) 
                     #f)))

;; TDA DRIVE
;; IMPLEMENTACION = LETRA(CHAR) X NOMBRE(STRING) X USUARIOS(LIST DE USER) X DATOS/CONTENIDO(FOLDERS/FILES)
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

;; TDA DIRECTORY
;; IMPLEMENTACION = NOMBRE(STRING) X DATOS/CONTENIDO(FOLDERS/FILES)
;; DOMINIO = NOMBRE
;; RECORRIDO = DIRECTORIO
;; RECURSION = N/A
;; DESCRIPCION = FUNCION QUE POSTERIORMENTE SE UTILIZARÁ PARA GENERAR UN DIRECTORIO EN EL DRIVE

(define (dir-name-maker name drive)
  (string-append (string drive) ":/" name "/"))

(define (dir-name-maker-subdir name drive subdir)
  (string-append (string drive) "/" (substring subdir 1(string-length subdir))  name "/"))

(define (directory name drive usuario system)
  (if (and
       (string? name)
       (char? drive)
       (user usuario))
      (list drive (if(not(or(char?(string-ref(car(get-system-current-path system))0))(equal?(string-length(get-system-current-path system))3)))
                     (dir-name-maker name drive)
                     (dir-name-maker-subdir name drive (car(get-system-current-path system)))) (datesys current-seconds) usuario)
      #f))



;; TDA FILE
;; IMPLEMENTACION = NOMBRE(STRING) X TIPO/EXTENSIÓN(STRING) X CONTENIDO(STRING)
;; DOMINIO = NOMBRE, TIPO, CONTENIDO
;; RECORRIDO = FILE
;; RECURSION = N/A
;; DESCRIPCION = FUNCION QUE POSTERIORMENTE SE UTILIZARA PARA GENERAR UN FILE

(define (file-name-maker name ext drive current-dir)
  (string-append (string drive) (substring current-dir 1(string-length current-dir)) name ext))

(define file(lambda(name ext content)
              (if (and
                  (string? name)
                  (string? ext)
                  (string? content))
                  (list name ext content)
                  #f)))

(define file-path(lambda(drive path file ext user)
                   (list drive path file ext (datesys current-seconds) user)))





#|
(define file-path(lambda drive path file ext date user)
  (list drive (file-name-maker (car file) drive (get-current-path system)) file ext (datesys current-seconds) user))
|#

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

;; OTRAS FUNCIONES:
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

(define (make-system current-user name date users drives current-drive current-path paths)
  (list current-user name date users drives current-drive current-path paths))

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
    (cadddr(reverse system))))
;; FUNCION GET-SYSTEM-CURRENT-DRIVE:
(define get-system-current-drive
  (lambda(system)
    (caddr(reverse system))))
;; FUNCION GET-SYSTEM-CURRENT-PATH:
(define get-system-current-path
  (lambda(system)
    (cadr(reverse system))))
;; FUNCION GET-SYSTEM-PATHS:
(define get-system-paths
  (lambda(system)
    (car(reverse system))))

;; FUNCION TAKEOUT-DRIVE:
(define (takeout-drive drive)
  (cond ((null? drive) '()) 
        ((member #t (car drive))
         (takeout-drive (cdr drive))) 
        (else (cons (car drive) (takeout-drive (cdr drive))))))

;; FUNCION MAKE-DRIVE:
(define (make-drive letter name capacity)
  (drive letter name capacity))

;; FUNCION MAKE-USUARIO:
(define (make-user name)
  (user name))

;; FUNCION SWITCH-DRIVE-INNER:
(define (switch-drive-inner system letter)
  (cond ((null? system) '()) 
        ((member letter (car system))
         (cons (cons #t (cons letter (cdr (car system)))) (cdr system)) )
        (else (cons (car system) (switch-drive-inner (cdr system) letter)))))

;; FUNCION CHECK-IF-ANY-DRIVE-IN-USE:  
(define (check-if-any-drive-in-use lst)
  (if(null?(get-system-current-drive lst))
     #f
     #t))

;; FUNCION REMOVES-USE-STATE-IN-DRIVE:
(define (removes-use-state-in-drive lst)
  (make-system(get-system-current-user system)
                    (get-system-name system)
                    (get-system-date system)
                    (get-system-user system)
                    (get-system-drive system)
                    null
                    (get-system-current-path system)
                    (get-system-paths)))

;; FUNCION SLASH-REMOVER:
(define (slash-remover lst)
  (if (null? lst)       ; Lista vacia devuvelve la lista
      lst
      (if (char=? (car lst) #\/) 
          (cdr lst)
          (slash-remover (cdr lst)))))

;; FUNCION BACK-CD:
;; DESCRIPCION: IMPLEMENTADA PARA DAR SOLUCION A LA OPCION DEL CD ".." LO QUE HACE ES
;; MODIFICAR GENERAR LA RUTA PARA LA CARPETA QUE CONTIENE A LA ACTUAL.
(define back-cd
  (lambda(path)
    (string-append(list->string(reverse(slash-remover(slash-remover(reverse(string->list path))))))"/"))) 

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
    (if (null?(get-system-drive system))
        (make-system(get-system-current-user system)
                    (get-system-name system)
                    (get-system-date system)
                    (get-system-user system)
                    (cons (make-drive letter name capacity)(get-system-drive system))
                    (get-system-current-drive system)
                    (get-system-current-path system)
                    (get-system-paths system))
              (if(existing-drive? letter (collector-letter (get-system-drive system)))
                 #f
                 (make-system(get-system-current-user system)
                    (get-system-name system)
                    (get-system-date system)
                    (get-system-user system)
                    (cons (make-drive letter name capacity)(get-system-drive system))
                    (get-system-current-drive system)
                    (get-system-current-path system)
                    (get-system-paths system)))))))

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
                     (get-system-drive system)
                     (get-system-current-drive system)
                     (get-system-current-path system)
                     (get-system-paths system))))))


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
         (if(null?(get-system-current-user system))
            (make-system(cons name(get-system-current-user system))
                        (get-system-name system)
                        (get-system-date system)
                        (get-system-user system)
                        (get-system-drive system)
                        (get-system-current-drive system)
                        (get-system-current-path system)
                        (get-system-paths system))
            #f)
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
                     (get-system-drive system)
                     null
                     null
                     (get-system-paths system)))))

;; REQUERIMIENTO FUNCIONAL N°7:
;; SWITCH-DRIVE
;; IMPLEMENTACION = FUNCION CURRIFICADA, AGREGA UN BOOLEANO VERDADERO PARA EL
;; DRIVE QUE VA A SER USADO
;; DOMINIO = SYSTEM X DRIVE(CHAR)
;; RECORRIDO = SYSTEM
;; RECURSION = N/A (FUNCIONES INTERIORES SI, PERO SWITCH-DRIVE SE LLAMA UNA SOLA VEZ).
;; DESCRIPCION = AGREGA UN #t AL DRIVE QUE VA A SER OCUPADO, DE HABER UNO EN USO SE
;; CAMBIA EL DRIVE EN USO PARA EL NUEVO QUE ESTA SIENDO AGREGADO. NO FUNCIONA DE NO
;; HABER LOGEADO ANTES. CADA VEZ QUE SE INGRESA A UN DRIVE SE VA A LA RAÍZ "/".

(define switch-drive
  (lambda(system)
    (lambda(letter)
      (if(null?(get-system-current-user system))
         #f;Caso de no haber logeado
         (if(existing-drive? letter (collector-letter (get-system-drive system)))
            (if(null? (get-system-current-drive system)) 
               (make-system (get-system-current-user system); En caso de que no haya ningún drive en el momento
                            (get-system-name system)
                            (get-system-date system)
                            (get-system-user system)
                            (get-system-drive system)
                            (cons letter(get-system-current-drive system))
                            (cons "/"(get-system-current-path system))
                            (get-system-paths system))
               (make-system (get-system-current-user system)
                            (get-system-name system)
                            (get-system-date system)
                            (get-system-user system)
                            (get-system-drive system)
                            (cons letter (cdr(get-system-current-drive system)))
                            (list "/")
                            (get-system-paths system))) 
            #f))))); Caso de que el drive que se quiera cambiar no exista
 
;; REQUERIMIENTO FUNCIONAL N°9:
;; MD
;; IMPLEMENTACION = FUNCION CURRIFICADA. AGREGA UNA LISTA REPRESENTANDO UN DIRECTORIO
;; DOMINIO = SYSTEM X NEWDIRECTORY(STRING)
;; RECORRIDO = SYSTEM
;; RECURSION = N/A (FUNCIONES INTERIORES SI, PERO MD SE LLAMA UNA SOLA VEZ).
;; DESCRIPCION = AGREGA EL DIRECTORIO DESEADO AL DRIVE QUE ESTA SIENDO USADO EN EL
;; MOMENTO, ESTA CONTIENE LA INFO. REQUERIDA EN EL ENUNCIADO

(define md
  (lambda(system)
     (lambda(name-directory)
       (make-system (get-system-current-user system)
                            (get-system-name system)
                            (get-system-date system)
                            (get-system-user system)
                            (get-system-drive system)
                            (get-system-current-drive system)
                            (get-system-current-path system)
                            (cons (directory name-directory (car(get-system-current-drive system))(car(get-system-current-user system))system) (get-system-paths system))))))



;; REQUERIMIENTO FUNCIONAL N°10:
;; CD
;; IMPLEMENTACION = FUNCION CURRIFICADA. AGREGA 
;; DOMINIO = 
;; RECORRIDO = 
;; RECURSION = 
;; DESCRIPCION = 
;;

(define cd
  (lambda(system)
    (lambda(path)
      (if(string? path)
         (if(or(equal? ".." path)(equal? "/" path))
            (if(equal? ".." path)
               (make-system
                (get-system-current-user system)
                (get-system-name system)
                (get-system-date system)
                (get-system-user system)
                (get-system-drive system)
                (get-system-current-drive system)
                (list(back-cd(car(get-system-current-path system))))
                (get-system-paths system))
               (make-system
                (get-system-current-user system)
                (get-system-name system)
                (get-system-date system)
                (get-system-user system)
                (get-system-drive system)
                (get-system-current-drive system)
                (list "/")
                (get-system-paths system)))
            (make-system
                (get-system-current-user system)
                (get-system-name system)
                (get-system-date system)
                (get-system-user system)
                (get-system-drive system)
                (get-system-current-drive system)
                (list (dir-name-maker-subdir path (car(get-system-current-drive system))(car(get-system-current-path system)))) 
                (get-system-paths system)))
         #f)))); Caso no entrega string




;; REQUERIMIENTO FUNCIONAL N°10:
;; ADD-FILE
;; IMPLEMENTACION = FUNCION CURRIFICADA. AGREGA 
;; DOMINIO = 
;; RECORRIDO = 
;; RECURSION = 
;; DESCRIPCION = 
;;

(define add-file
  (lambda(system)
    (lambda(new-file)
         (make-system
                (get-system-current-user system)
                (get-system-name system)
                (get-system-date system)
                (get-system-user system)
                (get-system-drive system)
                (get-system-current-drive system)
                (get-system-current-path system) 
                (cons(file-path (car(get-system-current-drive system))(file-name-maker (car new-file)(cadr new-file)(car(get-system-current-drive system))(car(get-system-current-path system))) new-file (cadr new-file) (get-system-current-user system)) (get-system-paths system)))
         )))
          
                












          

(display "Campo de pruebas: \n")
(define S0(system "Kali Linux"))
;S0
(define S1((run S0 add-drive)#\C "Drive1" 2424))
;S1
(define S2((run S1 register)"Flash"))
;S2
(define S3((run S2 register)"Batman"))
;S3
(define S4((run S3 add-drive)#\D "Drive2" 1000))
;S4
(define S5((run S4 register)"Robin"))
;S5
(define S6((run S5 login)"Batman"))
;S6
(define S7((run S6 switch-drive)#\C))
;S7
(define S8((run S7 switch-drive)#\D))
;S8
(define S9((run S8 md)"NewMd"))
;S9
(define S10((run S9 md)"LAB-PDP"))
;S10
(define S11((run S10 switch-drive)#\C))
;S11
(define S12((run S11 md)"LAB-PDP2"))
;S12
(define S13((run S12 cd)"LAB-PDP2"))
S13
(define S14((run S13 md)"Wallpapers"))
S14
(define S15((run S14 cd)"Wallpapers"))
S15
(define S16((run S15 cd)".."))
S16
(define F1(file "Texto Calculo" ".txt" "En este texto..."))
F1
(define S17((run S16 add-file)F1))
S17

