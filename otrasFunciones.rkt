#lang racket
(require (file "system.rkt"))
(require (file "drive.rkt"))
(require (file "directory.rkt"))
(require (file "filee.rkt"))
(require "user.rkt")
(provide(all-defined-out))

;; OTRAS FUNCIONES:
;; EN ESTA PARTE SE PRESENTA UN GRUPO DE FUNCIONES NO REQUERIDAS EN EL ENUNCIADO OFICIAL
;; CREADAS CON EL PROPOSITO DE LOGRAR DE MEJOR MANERA LOS DIVERSOS OBJETIVOS. EN ALGUNOS
;; CASOS ESTAS REPRESENTARAN UNA OPTIMIZACION PARA EL PROYECTO.

;; FUNCION COLLECTOR-LETTER-LST
;; IMPLEMENTACION =  DECLARATIVA, USO DE LISTA
;; DOMINIO = DRIVES(LISTA DE DRIVES)
;; RECORRIDO = LISTA CON LAS LETRAS DE TODOS LOS DRIVES EXISTENTES
;; RECURSION = NATURAL
;; DESCRIPCION: SU FUNCION ES RECOLECTAR LA LETRA DE TODOS LOS DRIVES EXISTENTES PARA
;; PODER IDENTIFICAR SI EL DRIVE QUE SERA INGRESADO YA EXISTE.

(define (collector-letter lst)
  (cond ((null? lst) '())
        ((not (list? (car lst))) '())
        (else (cons (car (car lst))
                    (collector-letter (cdr lst))))))

;; FUNCION EXISTING-DRIVE?
;; IMPLEMENTACION =  DECLARATIVA
;; DOMINIO = DRIVE, LISTA 
;; RECORRIDO = BOOLEANO
;; RECURSION = N/A
;; DESCRIPCION: COMPARA SI EL DRIVE QUE QUIERE SER INGRESADO EXISTE YA EN LOS DRIVES
;; EXISTENTES.

(define (existing-drive? new-drive drives)
  (if (not (member new-drive drives))
      #f
      (eqv? new-drive (car (filter (lambda (x) (eqv? new-drive x)) drives)))))

;; FUNCION MAKE-DRIVE
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = LETTER(CHAR), NAME(STRING), CAPACITY(NUMBER)
;; RECORRIDO = DRIVE
;; RECURSION = N/A
;; DESCRIPCION = RECIBE LOS DATOS NECESARIOS PARA CREAR UN DRIVE.

(define (make-drive letter name capacity)
  (drive letter name capacity))

;; FUNCION MAKE-USER
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = NAME(STRING)
;; RECORRIDO = USER
;; RECURSION = N/A
;; DESCRIPCION = RECIBE UN STRING Y LO VALIDA A TRAVES DEL TDA USER DEFINIDO PREVIAMENTE.

(define (make-user name)
  (user name))

;; FUNCION SLASH-REMOVER
;; IMPLEMENTACION = DECLARATIVA, MANEJO DE STRING
;; DOMINIO = LISTA(UN STRING TRANSFORMADO A UNA LISTA PARA PODER SER MANIPULADO)
;; RECORRIDO = STRING CON SLASH REMOVIDO Y LO QUE LO PRECEDE ANTERIORMENTE.
;; RECURSION = NATURAL
;; DESCRIPCION = EL PROPOSITO DE ESTA FUNCION ES ENCONTRAR SUBDIREACTORIOS, SE BASA
;; EN EL LOS SLASHES DE UNA RUTA, EJEMPLO DE ESTO SERIA:
;; C:/FOLDER1/FOLDER2/
;; ELMINA EL PRIMER SLASH Y SE DETIENE AL ENCONTRAR EL SEGUNDO:
;; C:/FOLDER1/

(define (slash-remover lst)
  (if (null? lst)       ; Lista vacia devuvelve la lista
      lst
      (if (char=? (car lst) #\/) 
          (cdr lst)
          (slash-remover (cdr lst)))))

;; FUNCION BACK-CD:
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = STRING
;; RECORRIDO = STRING
;; RECURSION = N/A
;; DESCRIPCION: IMPLEMENTADA PARA DAR SOLUCION A LA OPCION DEL CD ".." LO QUE HACE ES
;; MODIFICAR GENERAR LA RUTA PARA LA CARPETA QUE CONTIENE A LA ACTUAL.

(define back-cd
  (lambda(path)
    (string-append(list->string(reverse(slash-remover(slash-remover(reverse(string->list path))))))"/")))

;; FUNC. ALPHABET CONTIENE LOS CARACTERES DEL ABECEDARIO/SPECIAL-CHARAC Y SE USA PARA MANIPULAR STRINGS.
;; FUNC. SPECIAL-CHARAC CONTIENE CARACTERES ESPECIALES QUE SE PUEDAN ENTREGAR EN UN DEL.

(define alphabet (list #\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K
                       #\L #\M #\N #\O #\P #\Q #\R #\S #\T #\U #\V
                       #\W #\X #\Y #\Z #\a #\b #\c #\d #\e #\f #\g
                       #\h #\i #\j #\k #\l #\m #\n #\o #\p #\q #\r
                       #\s #\t #\u #\v #\w #\x #\y #\z #\Ñ #\ñ))

(define special-charac(list #\* #\.))

      
;; FUNCIONES PARA OPCIONES DE FUNCION DEL
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = STRING
;; RECORRIDO = NUMERO QUE REPRESENTA LA OPCION QUE SE EJECUTARA
;; RECURSION = N/A
;; DESCRIPCION = ENTREGA UN NUMERO QUE INDICA QUE TIPO OPCION DEL COMANDO
;; DEL SE DEBE EJECUTAR

;; OP-DEL-ALL
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = STRING 
;; RECORRIDO = NUMERO
;; RECURSION = N/A
;; DESCRIPCION = RETORNA UN 1 EN CASO DE QUE EL STRING INGRESADO SEA EL CASO
;; QUE INDICA BORRAR TODOS LOS ARCHIVOS.
;; SE DESEAN BORRAR TODOS LOS ARCHIVOS EN ESTE CASO
;; CASO => *.*  

(define op-del-all
  (lambda(str)
    (if(string? str)
       (if(and(equal?(length(string->list str))3)
              (equal? #\* (car(string->list str)))
              (equal? #\. (cadr(string->list str)))
              (equal? #\* (caddr(string->list str))))
          1
          0)
       #f)))

;; OP-DEL-BY-EXT
;; IMPLEMENTACION = DECLARATIVA 
;; DOMINIO = STRING
;; RECORRIDO = NUMERO 
;; RECURSION = N/A
;; DESCRIPCION = RETORNA UN 2 EN CASO DE QUE EL STRING INGRESADO SEA EL CASO
;; QUE INDICA BORRAR TODOS LOS ARCHIVOS QUE CUMPLAN CON UNA EXTENCION EN
;; ESPECIFICO.
;; EJEMPLO CON EL QUE SE DESEA BORRAR TODOS LOS ARCHIVOS .TXT:
;; CASO => *.txt 

(define op-del-by-ext
  (lambda(str)
    (if(string? str)
       (if(and(list?(member #\. (string->list str)))
              (not(equal?(length(string->list str))3))
              (equal? 2 (length(member #\. (reverse(string->list str)))))
              (equal? #\* (cadr(member #\. (reverse(string->list str))))))
          2
          0)
       #f)))


;; OP-DEL-BY-LETTER-AND-EXT
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = STRING
;; RECORRIDO = NUMERO
;; RECURSION = N/A
;; DESCRIPCION = RETORNA UN 3 EN CASO DE QUE EL STRING INGRESADO SE UNA LETRA Y
;; UNA EXTENSION, LO QUE INDICARIA BORRAR TODOS LOS ARCHIVOS QUE INICIEN CON LA
;; LETRA INGRESADA Y CUMPLEN CON LA EXTENSION EN ESPECIFICO.
;; EJEMPLO CON EL QUE SE DESEA BORRAR TODOS LOS ARCHIVOS QUE COMIENZAN CON LA LETRA
;; G Y TIENEN LA EXTENSION TXT.
;; CASO => g*.txt

(define op-del-by-letter-and-ext
  (lambda(str)
    (if(string? str)
       (if(and(list?(member #\. (string->list str)))
              (equal? 3 (length(member #\. (reverse(string->list str)))))
              (equal? #\* (cadr(member #\. (reverse(string->list str)))))
              (list?(member (caddr(member #\. (reverse(string->list str)))) alphabet)))
          3
          0)
       #f)))

;; OP-DEL-FILE
;; IMPLEMENTACION = DECLARATIVA 
;; DOMINIO = STRING
;; RECORRIDO = NUMERO
;; RECURSION = N/A
;; DESCRIPCION = RETORNA UN 4 EB CASO DE QUE EL STRING SEA EL NOMBRE DE UN ARCHIVO
;; QUE SE NECESITA SER ELIMINADO.
;; EJEMPLO EN EL QUE SE DESEA BORRAR UN ARCHIVO LLAMADO FILE DEL TIPO .TXT
;; CASO => file.txt

(define op-del-file
  (lambda(str)
    (if(string? str)
       (if(and(list?(member #\. (string->list str)))
              (not(equal? #\* (cadr(member #\. (reverse(string->list str)))))))
          4
          0)
       #f)))

;; OP-DEL-DIR
;; IMPLEMENTACION = DECLARATIVA 
;; DOMINIO = STRING
;; RECORRIDO = NUMERO 
;; RECURSION = N/A
;; DESCRIPCION = RETORNA UN 5 EN CASO DE QUE EL STRING SEA EL PATH INGRESADO, SEA
;; EL NOMBRE DE UN DIRECTORIO.
;; EJEMPLO EN EL QUE SE DESEA ELIMINAR UN DIRECTORIO
;; CASO => "folder1"

(define op-del-dir
  (lambda(str)
    (if(string? str)
       (if(or(list?(member #\. (string->list str)))(list?(member #\* (string->list str))))
          0
          5)
       #f)))

;; GET-DEL-OPTION
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = STRING
;; RECORRIDO = NUMERO QUE REPRESENTA LA OPCION QUE SE EJECUTARA
;; RECURSION = N/A
;; DESCRIPCION = CON AYUDA DE LAS FUNCIONES PREVIAMENTE DEFINIDAS SE SABE LA OPCION
;; DE CUAL TIPO DE DEL SE DEBE APLICAR.

(define get-del-option
  (lambda(str)(+
               (op-del-all str)
               (op-del-by-ext str)
               (op-del-by-letter-and-ext str)
               (op-del-file str)
               (op-del-dir str))))

;; DELETE-EXT
;; IMPLEMENTACION = DECLARATIVA 
;; DOMINIO = STRING, LISTA
;; RECORRIDO = LISTA 
;; RECURSION = N/A
;; DESCRIPCION = ELIMINA LOS ARCHIVOS QUE COINCIDAN CON LA EXTENSION DADA.

(define (delete-ext str lst)
  (filter (lambda (sublst) (not (member str sublst)))
          lst))

;; DELETE-BY-LETTER-AND-EXT
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = LISTA, CHAR, STRING
;; RECORRIDO = LISTA 
;; RECURSION = N/A
;; DESCRIPCION = ELIMINA SEGUN UNA LETRA Y UNA EXTENSION DADA.

(define (delete-by-letter-and-ext lst letter str)
  (filter (lambda (sublst)
            (or (= (length sublst) 4)
                (not (and (= (length sublst) 6)
                          (char=? (string-ref (car (caddr sublst)) 0) letter)
                          (equal? str (cadr (caddr sublst)))))))
          lst))

;; DEL-BY-FILENAME-1
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = STRING
;; RECORRIDO = STRING
;; RECURSION = N/A
;; DESCRIPCION = RECORTA EL NOMBRE DEL ARCHIVO ELIMINANDO LA EXTENSION.

(define del-by-filename-1
  (lambda(str)
    (if(string? str)
       (list->string(reverse(cdr(member #\. (reverse(string->list str))))))
       #f)))

;; DEL-BY-FILENAME-2
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = STRING
;; RECORRIDO = STRING
;; RECURSION = N/A
;; DESCRIPCION = RECORTA EL NOMBRE DEL ARCHIVO ELIMINANDO EL NOMBRE PARA SOLO
;; DEJAR LA EXTENSION.

(define del-by-filename-2
  (lambda(str)
    (if(string? str)
       (list->string(member #\. (string->list str)))
       #f)))

;; DEL-BY-NAME
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = LISTA, STRING, STRING
;; RECORRIDO = LISTA
;; RECURSION = NATURAL
;; DESCRIPCION = ELIMINA SEGUN NOMBRE, ES DECIR EN CASO DE QUE SE INDIQUE ALGO
;; DEL TIPO => "file.txt".

(define (del-by-name lst str1 str2)
  (cond ((null? lst) '())
        ((and (list? (car lst))
              (= (length (car lst)) 6)
              (or (member str1 (caddr (car lst)))
                  (member str2 (caddr (car lst)))))
         (del-by-name (cdr lst) str1 str2))
        ((and (list? (cadr (car lst)))
              (= (length (cadr (car lst))) 3)
              (equal? (car (cadr (car lst))) str1)
              (equal? (cadr (cadr (car lst))) str2)
              (member str1 (car (caddr (cadr (car lst)))))
              (member str2 (cadr (caddr (cadr (car lst))))))
         (del-by-name (cdr lst) str1 str2))
        (else (cons (car lst) (del-by-name (cdr lst) str1 str2)))))

;; GET-LETTER-DIR-DEL
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = STRING
;; RECORRIDO = STRING
;; RECURSION = N/A
;; DESCRIPCION = OBTIENE EL DIRECTORIO QUE SE DEBE ELIMINAR.

(define get-letter-dir-del
  (lambda(str)
    (if(string? str)
       (car(string->list str))
       #f)))

;; GET-EXT-DIR-DEL
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = STRING
;; RECORRIDO = STRING
;; RECURSION = N/A
;; DESCRIPCION = OBTIENE EXTENSION.

(define get-ext-dir-del
  (lambda(str)
    (if(string? str)
       (list->string(member #\. (string->list str)))
       #f)))

;; DELETE-BY-DIR
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = LISTA, STRING
;; RECORRIDO = LISTA
;; RECURSION = N/A
;; DESCRIPCION = BORRA SEGUN EL DIRECTORIO INDICADO.

(define (delete-by-dir lists str)
  (filter (lambda (lst) (not (string-contains? (cadr lst) str))) lists))

;; FUNCIONES EXTRAS DE RD

;; STRING-CONTAINS?
;; IMPLEMENTACION = RECURSIVA 
;; DOMINIO = STRING, STRING
;; RECORRIDO = BOOLEANO
;; RECURSION = NATURAL
;; DESCRIPCION = VERIFICA SI UN STRING ES CONTENIDO EN OTRO.

(define (string-contains? str sub)
  (cond ((>= (string-length str) (string-length sub))
         (or (string=? (substring str 0 (string-length sub)) sub)
             (string-contains? (substring str 1) sub)))
        (else #f)))

;; CHECK-FALSE
;; IMPLEMENTACION = RECURSIVA
;; DOMINIO = LISTA
;; RECORRIDO = LISTA O BOOLEANO
;; RECURSION = NATURAL
;; DESCRIPCION = CHECKEA SI UNA LISTA CONTIENE UN BOOLEANO FALSO.

(define check-false
  (lambda (lst)
    (if (null? lst)
        lst
        (if (list? lst)
            (if (equal? (car lst) #f)
                #f
                (if (check-false (cdr lst))
                    lst
                    #f))
            #f))))

;; DEL-INNER
;; IMPLEMENTACION = RECURSIVA
;; DOMINIO = LISTA, STRING
;; RECORRIDO = LISTA
;; RECURSION = NATURAL
;; DESCRIPCION = ELIMINA LISTAS SI CONTIENEN ALGUN STRING QUE CONTENGA
;; EL STRING DADO.

(define del-inner
  (lambda (lst str times)
    (if (null? lst)
        '()
        (if (eq? times 0)
            #f
            (if (string-contains? (cadr (car lst)) str)
                (del-inner (cdr lst) str (- times 1))
                (cons (car lst) (del-inner (cdr lst) str times)))))))

;; CHECK-IF-FILE
;; IMPLEMENTACION = DECLARATIVA 
;; DOMINIO = STRING
;; RECORRIDO = BOOLEANO
;; RECURSION = N/A
;; DESCRIPCION = ENTREGA TRUE PARA FILES Y FALSE PARA CARPETAS

(define check-if-file
  (lambda(str)
    (if(string? str)
       (if(list? (member #\. (string->list str)))
          #t
          #f)
       #f)))

;; FIND-FILE
;; IMPLEMENTACION = RECURSIVA
;; DOMINIO = STRING, STRING, LISTA
;; RECORRIDO = FILE
;; RECURSION = NATURAL
;; DESCRIPCION = BUSCA UN NOMBRE EN LOS PATHS.

; reuso de del-by-filename-1 y del-by-filename-2
;            (name-getter)        (ext-getter)

(define (find-file str1 str2 lst) ;entrega un file
  (cond ((null? lst) #f)
        ((and (list? (car lst))
              (= 6 (length (car lst)))
              (member str1 (caddr (car lst))) 
              (member str2 (caddr (car lst))))
         (caddr (car lst)))
        (else (find-file str1 str2 (cdr lst)))))

;; COPY-FILE
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = LISTA, LISTA, LISTA
;; RECORRIDO = STRING DE FILE PATH
;; RECURSION = N/A
;; DESCRIPCION = RETORNA UN FIKLE PATH.

(define copy-file 
  (lambda(src dir system)
    (file-path (car(get-system-current-drive system)) (string-append dir (car src)(cadr src)) src (cadr src) (get-system-current-user system))))

;; CHECK-IF-BELONGS-LST
;; IMPLEMENTACION = RECURSION DE COLA
;; DOMINIO = STRING, LISTA DE LISTAS
;; RECORRIDO = LISTA
;; RECURSION = DE COLA
;; DESCRIPCION = ACUMULA LAS LISTAS QUE CONTENGAN EL STRING DADO (PATH).

;copy-folder
(define (check-if-belongs-lst str lst-of-lst)
  (cond ((null? lst-of-lst) '())
        ((check-if-belongs-helper str (car lst-of-lst))
         (cons (car lst-of-lst)
               (check-if-belongs-lst str (cdr lst-of-lst))))
        (else (check-if-belongs-lst str (cdr lst-of-lst)))))

;; CHECK-IF-BELONGS-HELPER
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = STRING, LISTA
;; RECORRIDO = BOOLEANO
;; RECURSION = N/A
;; DESCRIPCION = CHECKEA SI EL STRING ES CONTENIDO POR EL SEGUNDO ELEMENTO DE LA LISTA.

(define (check-if-belongs-helper str lst)
  (string-contains? (cadr lst) str))

;; GET-FOLDERS-APPLY
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = STRING, LISTA
;; RECORRIDO = LISTA
;; RECURSION = N/A
;; DESCRIPCION = RETORNA DIRECTORIOS QUE CUMPLAN SEGUN EL STRING DADO.

(define get-folders-apply
 (lambda(str lst)
   (check-if-belongs-lst str lst)))

;; PATH-FROM-COPIES
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = STRING, LISTA
;; RECORRIDO = LISTA
;; RECURSION = N/A
;; DESCRIPCION = GENERA UNA LISTA A PARTIR DEL STRING DADO Y UNA LISTA ACUMULANDO
;; LOS PATHS.

(define (path-from-copies str lst)
  (map (lambda (inner)
         (list (car inner) str (cddr inner)))
       lst))

;; COPY-FOLDER
;; IMPLEMENTACION = DECLARATIVA
;; DOMINIO = STRING, STRING ,LISTA
;; RECORRIDO = LISTA
;; RECURSION = N/A
;; DESCRIPCION = COPIA UN DIRECTORIO

(define copy-folder
  (lambda(src dir paths)
    (path-from-copies dir (get-folders-apply src paths))))

;; COMIENZO MOVE

;; DELETE-ORIGINAL
;; IMPLEMENTACION = RECURSIVA
;; DOMINIO = LISTA, STRING, STRING
;; RECORRIDO = LISTA
;; RECURSION = NATURAL
;; DESCRIPCION = AL MOVER UN ARCHIVO SE ENTIENDE QUE DEJA DE EXISTIR EN DONDE
;; PRIMERO ESTABA PARA UBICARSE EN SU NUEVA LOCACIÓN, ESTA FUNCION ELIMINA
;; EL ARCHIVO EN SU PRIMERA UBICACION.

(define (delete-original lsts str1 str2)
  (cond ((null? lsts) '())
        ((and (= (length (car lsts)) 6)
              (member str1 (cadr (car lsts)))
              (member str2 (cadr (car lsts))))
         (cons (car lsts) (delete-original (cdr lsts) str1 str2)))
        (else (delete-original (cdr lsts) str1 str2))))

;; DELETE-ORIGINAL-DIR
;; IMPLEMENTACION = RECURSIVA
;; DOMINIO = STRING, LISTA
;; RECORRIDO = LISTA
;; RECURSION = NATURAL
;; DESCRIPCION = MISMO PROCEDIMIENTO QUE LA FUNCION ANTERIORMENTE DEFINIDA
;; PERO AHORA PARA DIRECTORIOS.

(define (delete-original-dir str lsts)
  (cond ((null? lsts) '()) ; base case: empty list
        ((string-contains? (string-upcase (cadr (car lsts))) (string-upcase str))
         (delete-original-dir str (cdr lsts))) 
        (else (cons (car lsts) (delete-original-dir str (cdr lsts)))))) 







