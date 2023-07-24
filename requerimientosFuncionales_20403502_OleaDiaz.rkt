#lang racket
(provide(all-defined-out))
(require (file "otrasFunciones_20403502_OleaDiaz.rkt"))
(require (file "system_20403502_OleaDiaz.rkt"))
(require (file "drive_20403502_OleaDiaz.rkt"))
(require (file "directory_20403502_OleaDiaz.rkt"))
(require (file "filee_20403502_OleaDiaz.rkt"))

;; REQUERIMIENTO FUNCIONAL N°3:
;; RUN
;; IMPLEMENTACION = USO DE FUNCION DE ORDEN SUPERIOR 
;; DOMINIO = SYSTEM, COMANDO(FUNCION)
;; RECORRIDO = SYSTEM (CON EL COMANDO APLICADO)
;; RECURSION = N/A
;; DESCRIPCION = FUNCION DE ORDEN SUPERIOR QUE RECIBE UN SISTEMA Y UN COMANDO(FUNCION)
;; PARA POSTERIORMENTE APLICAR ESE COMANDO SOBRE EL SISTEMA.
(define (run sys f)
  (f sys))

;; REQUERIMIENTO FUNCIONAL N°4:
;; ADD-DRIVE
;; IMPLEMENTACION = USO DE CURRIFICACION 
;; DOMINIO = SYSTEM, (LETTER(CHAR), NAME(STRING), CAPACITY(NUMBER))
;; RECORRIDO =  SYSTEM
;; RECURSION =  N/A
;; DESCRIPCION = FUNCION CURRIFICADA QUE AGREGA UN DRIVE A UN SISTEMA. VERIFICA SI
;; LA LETRA ES UNICA.

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
                 system
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
;; DOMINIO = SYSTEM, (USER(STRING))
;; RECORRIDO = SYSTEM
;; RECURSION = N/A
;; DESCRIPCION = AGREGA UN USUARIO A EL SISTEMA, ESTE NO PUEDE EXISTIR PREVIAMENTE
;; DE SER ASÍ CREARA UN BOOLEANO FALSO.

(define register
  (lambda(system)
    (lambda(name)
      (if(list?(member name (get-system-user system)))
         system
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
;; DOMINIO = SYSTEM, (USER(STRING))
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
            system)
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


;; REQUERIMIENTO FUNCIONAL N°8:
;; SWITCH-DRIVE
;; IMPLEMENTACION = FUNCION CURRIFICADA, AGREGA UN BOOLEANO VERDADERO PARA EL
;; DRIVE QUE VA A SER USADO
;; DOMINIO = SYSTEM, DRIVE(CHAR)
;; RECORRIDO = SYSTEM
;; RECURSION = N/A (FUNCIONES INTERIORES SI, PERO SWITCH-DRIVE SE LLAMA UNA SOLA VEZ).
;; DESCRIPCION = AGREGA UN #t AL DRIVE QUE VA A SER OCUPADO, DE HABER UNO EN USO SE
;; CAMBIA EL DRIVE EN USO PARA EL NUEVO QUE ESTA SIENDO AGREGADO. NO FUNCIONA DE NO
;; HABER LOGEADO ANTES. CADA VEZ QUE SE INGRESA A UN DRIVE SE VA A LA RAÍZ "/".

(define switch-drive
  (lambda(system)
    (lambda(letter)
      (if(null?(get-system-current-user system))
         system;Caso de no haber logeado
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
            system))))); Caso de que el drive que se quiera cambiar no exista
 
;; REQUERIMIENTO FUNCIONAL N°9:
;; MD
;; IMPLEMENTACION = FUNCION CURRIFICADA. AGREGA UNA LISTA REPRESENTANDO UN DIRECTORIO
;; DOMINIO = SYSTEM, NEWDIRECTORY(STRING)
;; RECORRIDO = SYSTEM
;; RECURSION = N/A (FUNCIONES INTERIORES SI, PERO MD SE LLAMA UNA SOLA VEZ).
;; DESCRIPCION = AGREGA EL DIRECTORIO DESEADO AL DRIVE QUE ESTA SIENDO USADO EN EL
;; MOMENTO, ESTA CONTIENE LA INFO. REQUERIDA EN EL ENUNCIADO

(define md
  (lambda(system)
     (lambda(name-directory)
       (if(existing-folder? (get-system-paths system) (string-append (string(car(get-system-current-drive system)))"/" name-directory "/"))
       system
       (if(existing-folder? (get-system-paths system) (string-append (car(get-system-current-path system))(string(car(get-system-current-drive system)))"/" name-directory "/"))
       system
       (make-system (get-system-current-user system)
                            (get-system-name system)
                            (get-system-date system)
                            (get-system-user system)
                            (get-system-drive system)
                            (get-system-current-drive system)
                            (get-system-current-path system)
                            (cons (directory name-directory (car(get-system-current-drive system))(car(get-system-current-user system))system) (get-system-paths system))))))))



;; REQUERIMIENTO FUNCIONAL N°10:
;; CD
;; IMPLEMENTACION = FUNCION CURRIFICADA. DECLARATIVA
;; DOMINIO = SYSTEM, PATH(STRING)
;; RECORRIDO = SYSTEM CON LA RUTA ACTUAL CAMBIADA A LA DESEADA
;; RECURSION = N/A
;; DESCRIPCION = SE APLICA LA FUNCION TOMANDO EN CUENTA SUS OPCIONES VARIABLES. CAMBIA LA RUTA ACTUAL.

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
                (if (existing-folder? (get-system-paths system) (string-append (car(get-system-current-path system))(string(car(get-system-current-drive system)))"/" path "/"))
                    (get-system-current-path)
                    (list (dir-name-maker-subdir path (car(get-system-current-drive system))(car(get-system-current-path system))))) ;; Checkeando que la carpeta exista
                (get-system-paths system)))
         #f)))); Caso no entrega string

;; REQUERIMIENTO FUNCIONAL N°11:
;; ADD-FILE
;; IMPLEMENTACION = FUNCION CURRIFICADA, DECLARATIVA
;; DOMINIO = SYSTEM, FILE
;; RECORRIDO = SYSTEM CON EL FILE AÑADIDO
;; RECURSION = N/A
;; DESCRIPCION = SE AGREGA UN FILE QUE DEBE SER PREVIAMENTE DEFINIDO

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


;; REQUERIMIENTO FUNCIONAL N°12:
;; DEL
;; IMPLEMENTACION = FUNCION CURRIFICADA. ELIMINA EL ARCHIVO O SEGUN LA INDICACION
;; DOMINIO = SYSTEM, STRING
;; RECORRIDO = SYSTEM CON LA SOLICITUD DE DEL APLICADA
;; RECURSION = N/A
;; DESCRIPCION = ELIMINA SEGUN LO QUE SE INDICA.

(define del
  (lambda(system)
    (lambda(f-name-or-pattern)
      (if(string? f-name-or-pattern)
         (if(equal? 1 (get-del-option f-name-or-pattern))
            (make-system
                (get-system-current-user system)
                (get-system-name system)
                (get-system-date system)
                (get-system-user system)
                (get-system-drive system)
                (get-system-current-drive system)
                (list "/")
                null)
            (if(equal? 2 (get-del-option f-name-or-pattern))
              (make-system
                (get-system-current-user system)
                (get-system-name system)
                (get-system-date system)
                (get-system-user system)
                (get-system-drive system)
                (get-system-current-drive system)
                (list "/")
                (delete-ext (get-ext-dir-del f-name-or-pattern) (get-system-paths system)))
              (if(equal? 3 (get-del-option f-name-or-pattern))
                 (make-system
                  (get-system-current-user system)
                  (get-system-name system)
                  (get-system-date system)
                  (get-system-user system)
                  (get-system-drive system)
                  (get-system-current-drive system)
                  (list "/")
                  (delete-by-letter-and-ext (get-system-paths system) (get-letter-dir-del f-name-or-pattern) (get-ext-dir-del f-name-or-pattern)))
                 (if(equal? 4 (get-del-option f-name-or-pattern))
                    (make-system
                     (get-system-current-user system)
                     (get-system-name system)
                     (get-system-date system)
                     (get-system-user system)
                     (get-system-drive system)
                     (get-system-current-drive system)
                     (list "/")
                     (del-by-name (get-system-paths system) (del-by-filename-1 f-name-or-pattern) (del-by-filename-2 f-name-or-pattern)))
                    (if(equal? 5 (get-del-option f-name-or-pattern))
                       (make-system
                        (get-system-current-user system)
                        (get-system-name system)
                        (get-system-date system)
                        (get-system-user system)
                        (get-system-drive system)
                        (get-system-current-drive system)
                        (list "/")
                        (delete-by-dir (get-system-paths system) f-name-or-pattern))
                       #f)))))#f))))

;; REQUERIMIENTO FUNCIONAL N°13:
;; RD
;; IMPLEMENTACION = FUNCION CURRIFICADA. DECLARATIVA
;; DOMINIO = SYSTEM, STRING
;; RECORRIDO = SYSTEM CON LA SOLICITUD APLICADA
;; RECURSION = N/A
;; DESCRIPCION = ELIMINA DIRECTORIO SOLO EN CASO DE ESTAR VACIO

(define rd
  (lambda(system)
    (lambda(path)
      (if(string? path)
         (make-system
                (get-system-current-user system)
                (get-system-name system)
                (get-system-date system)
                (get-system-user system)
                (get-system-drive system)
                (get-system-current-drive system)
                (get-system-current-path system)
                (check-false(del-inner(get-system-paths system) path 2)))
         #f))))

;; REQUERIMIENTO FUNCIONAL N°14:
;; COPY
;; IMPLEMENTACION = FUNCION CURRIFICADA. DECLARATIVA
;; DOMINIO = SYSTEM, STRING
;; RECORRIDO = SYSTEM CON LA SOLICITUD DE DEL APLICADA
;; RECURSION = N/A
;; DESCRIPCION = COPIA ARCHIVOS O DIRECTORIOS SEGUN INDICADO

(define copy
  (lambda(system)
    (lambda(src dir)
      (if(and(string? src)(string? dir))
         (make-system
          (get-system-current-user system)
          (get-system-name system)
          (get-system-date system)
          (get-system-user system)
          (get-system-drive system)
          (get-system-current-drive system)
          (get-system-current-path system)
          (cons
           (if(check-if-file src)
              (copy-file (find-file (del-by-filename-1 src)(del-by-filename-2 src) (get-system-paths system)) dir system)
              (copy-folder src dir (get-system-paths system)))
           (get-system-paths system)))
         #f))))

;; REQUERIMIENTO FUNCIONAL N°15:
;; MOVE
;; IMPLEMENTACION = FUNCION CURRIFICADA. 
;; DOMINIO = SYSTEM, STRING
;; RECORRIDO = SYSTEM CON LA SOLICITUD DE DEL APLICADA
;; RECURSION = N/A
;; DESCRIPCION = MUEVE A UN PATH DADO Y ELIMINA DE LA RUTA DE ORIGEN

(define move
  (lambda(system)
    (lambda(src dir)
      (if(and(string? src)(string? dir))
         (if(list?(member #\. (string->list src)))      ;Caso archivo
            (make-system
             (get-system-current-user system)
             (get-system-name system)
             (get-system-date system)
             (get-system-user system)
             (get-system-drive system)
             (get-system-current-drive system)
             (get-system-current-path system)
             (cons(copy-file (find-file (del-by-filename-1 src)(del-by-filename-2 src) (get-system-paths system)) dir system)(delete-original (get-system-paths system)(del-by-filename-1 src)(del-by-filename-2 src))))
            (make-system                                ;Caso directorio
             (get-system-current-user system)
             (get-system-name system)
             (get-system-date system)
             (get-system-user system)
             (get-system-drive system)
             (get-system-current-drive system)
             (get-system-current-path system)
             (cons (copy-folder src dir (delete-original-dir src (get-system-paths system))) (get-system-paths system))))
         #f))))

;; REQUERIMIENTO FUNCIONAL N°16:
;; REN (RENAME)
;; IMPLEMENTACION = FUNCION CURRIFICADA. DECLARATIVA
;; DOMINIO = SYSTEM, STRING, STRING, SYSTEM
;; RECORRIDO = SYSTEM
;; RECURSION = N/A
;; DESCRIPCION = RENOMBRA UN ARCHIVO O DIRECTORIO
(define (systemRen-inner str1 str2 lst)
  (define (name-changer sublist)
    (if (and (= (length sublist) 6)
      (equal? (car sublist) str1))
      (cons str2 (cdr sublist))
      sublist))
    (map process-sublist lst))

(define systemRen 
  (lambda(system)
    (lambda(initialName newName)
      (if(and(string? initialName)(string? newName))
      (make-system
       (get-system-current-user system)
       (get-system-name system)
       (get-system-date system)
       (get-system-user system)
       (get-system-drive system)
       (get-system-current-drive system)
       (get-system-current-path system)
       (systemRen-inner initialName newName (get-system-paths system))
      )system))))
      


