#lang racket
(require (file "requerimientosFuncionales_20403502_OleaDiaz.rkt"))
(require (file "system_20403502_OleaDiaz.rkt"))
(require (file "filee_20403502_OleaDiaz.rkt"))
#|

LABORATORIO N°1 PARADIGMAS DE PROGRAMACION (1-2023)
PARADIGMA: FUNCIONAL | LENGUAJE DE PROGRAMACIÓN: SCHEME/RACKET 
POR: BASTIÁN OLEA DÍAZ
  
  |------------------------------------------|  
  |                                          |
  |  Script de Pruebas:                      |
  |  Laboratorio N°1 Paradigmas              |
  |  Programación funcional                  |
  |                                          |
  |   Por:                                   |
  |   Bastián Olea Díaz                      |
  |   Sección:                               |
  |   B-2                                    |  
  |                                          |
  |   **OBSERVACIÓN**                        |
  |   Las funciones definidas bajo           |
  |   comentarios de solo un punto y coma,   |
  |   es decir, ;texto. Serán las funciones  |
  |   del script básico de pruebas(requerido |
  |   en el enunciado) y las funciones       |
  |                                          |
  |                                          |
  |------------------------------------------|

|#

;; mis ejemplos

(display "Script de pruebas del estudiante: \n")
(display "\n")
(display "Pruebas -> system: \n")
(define BOD-A0(system "Linux"))
(define BOD-B0(system "Windows"))
(define BOD-C0(system "macOS"))
BOD-A0
BOD-B0
BOD-C0
(display "Pruebas -> add-drive: \n")
(define BOD-A1((run BOD-A0 add-drive)#\C "Drive1" 2424))
BOD-A1
(define BOD-A2((run BOD-A1 add-drive)#\D "Drive2" 1000))
BOD-A2
(define BOD-B1((run BOD-B0 add-drive)#\D "Drive2" "capacidad"))
BOD-B1 ;; El drive no se agrega debido a string incorrecto, muestra booleano falso
(display "Pruebas -> register: \n")
(define BOD-A3((run BOD-A2 register)"Flash"))
BOD-A3
(define BOD-A4((run BOD-A3 register)"Batman"))
BOD-A4 
(define BOD-A5((run BOD-A4 register)"Robin"))
BOD-A5
(display "Pruebas -> login y logout: \n")
(define BOD-A6((run BOD-A5 login)"Batman"))
BOD-A6
(define BOD-AB6(run BOD-A6 logout))
BOD-AB6
(define BOD-AB7((run BOD-AB6 login)"Flash"))
BOD-AB7
(define BOD-AB8(run BOD-AB7 logout))
BOD-AB8
(define BOD-AB9((run BOD-AB8 login)"Robin"))
BOD-AB9
(define BOD-AB10(run BOD-AB9 logout))
BOD-AB10
(display "Pruebas -> switch-drive: \n")
(define BOD-A7((run BOD-A6 switch-drive)#\C))
BOD-A7 
(define BOD-A8((run BOD-A7 switch-drive)#\D))
BOD-A8
(define BOD-AC9((run BOD-A8 switch-drive)#\E))
BOD-AC9 ;; Se muestra falso debido a que el drive indicado no ha sido creado previamente.
(display "Pruebas -> md: \n")
(define BOD-A9((run BOD-A8 md)"NewMd"))
BOD-A9
(define BOD-A10((run BOD-A9 md)"LAB-PDP"))
BOD-A10 
(define BOD-A11((run BOD-A10 switch-drive)#\C))
BOD-A11
(define BOD-A12((run BOD-A11 md)"LAB-PDP2"))
BOD-A12
(display "Pruebas -> cd: \n")
(define BOD-A13((run BOD-A12 cd)"LAB-PDP2"))
BOD-A13
(define BOD-A14((run BOD-A13 md)"Wallpapers"))
BOD-A14
(define BOD-A15((run BOD-A14 cd)"Wallpapers"))
BOD-A15
(define BOD-A16((run BOD-A15 cd)".."))
BOD-A16
;; Creación de files para hacer uso de add-file
(define BOD-AF1(filee "Informe Texto Calculo" ".txt" "En este texto..."))
(define BOD-AF2(filee "Drake - Jungle" ".mp3" "These days, im lettin god..."))
(define BOD-AF3(filee "Informe paradigmas" ".txt" "Laboratorio N°1"))
(display "Pruebas -> add-file: \n")
(define BOD-A17((run BOD-A16 add-file)BOD-AF1))
BOD-A17
(define BOD-A18((run BOD-A17 add-file)BOD-AF2))
BOD-A18
(define BOD-A19((run BOD-A18 cd)"LAB-PDP2/Wallpapers"))
BOD-A19
(define BOD-A20((run BOD-A19 add-file)BOD-AF3))
BOD-A20
(display "Pruebas -> del: \n")
(define BOD-AD21((run BOD-A20 del)"Informe Texto Calculo"))
BOD-AD21 ;; Se ha borrado el archivo Texto Calculo (En relación al system BOD-A20)
(define BOD-AD22((run BOD-A20 del)"*.txt"))
BOD-AD22 ;; Se han borrado los archivos txt (En relación al system BOD-A20)
(define BOD-AD23((run BOD-A20 del)"I*.txt"))
BOD-AD23 ;; Se han borrado los archivos txt y que además comienzan con una I(En relación al system BOD-A20)
(define BOD-AD24((run BOD-A20 del)"LAB-PDP2/Wallpapers"))
BOD-AD24 ;; Se ha borrado la carpeta "LAB-PDP2/Wallpapers" y los archivos pertencientes a esta (Informe paradigmas)(En relación al system BOD-A20)
(display "Pruebas -> rd: \n")
(define BOD-AD25((run BOD-A20 rd)"D/NewMd/"))
BOD-AD25 ;; Se borra la carpeta indicada ya que esta está vacia
(define BOD-AD26((run BOD-A20 rd)"LAB-PDP2/Wallpapers"))
BOD-AD26 ;; No se bora la carpeta indicada debido a que esta no está vacia
(define BOD-AD27((run BOD-A20 rd)"D/LAB-PDP/"))
BOD-AD27 ;; Se borra la carpeta indicada ya que esta está vacia
(display "Pruebas -> copy: \n")
(define BOD-AE21((run BOD-A20 copy)"Drake - Jungle" "D/NewMD/"))
BOD-AE21 ;; Se copia el archivo
(define BOD-AE22((run BOD-A20 copy)"Informe - Texto Calculo" "D/LAB-PDP/"))
BOD-AE22
(define BOD-AE23((run BOD-A20 copy)"Informe paradigmas" "D/NewMD/"))
BOD-AE23
(display "Pruebas -> move: \n")
(define BOD-AF21((run BOD-A20 move)"Drake - Jungle" "D/LAB-PDP/"))
BOD-AF21
(display "Pruebas -> systemRen: \n")
;; OBSERVACIÓN PARA HACER USO DE ESTA INGRESAR EL NOMBRE DEL ARCHIVO QUE SE DESEA MODIFICAR
;; SIN AGREGAR LA EXTENSIÓN. EJEMPLO: "Informe Texto Calculo" (NO "Informe Texto Calculo.txt")
(define BOD-AG21((run BOD-A20 systemRen)"Drake - Jungle" "Nuevo informe.txt"))
BOD-AG21
(display "Pruebas -> dir: \n")

; | A partir de aquí comienza el script de pruebas del enunciado. |



(display "\nScript de pruebas propio del enunciado oficial:")
;creando un sistema
(define S0 (system "newSystem"))

;añadiendo unidades. Incluye caso S2 que intenta añadir unidad con una letra que ya existe
(define S1 ((run S0 add-drive) #\C "SO" 1000))
; S1
(define S2 ((run S1 add-drive) #\C "SO1" 3000)) 
(define S3 ((run S2 add-drive) #\D "Util" 2000))

;añadiendo usuarios. Incluye caso S6 que intenta registrar usuario duplicado
(define S4 ((run S3 register) "user1"))
(define S5 ((run S4 register) "user1"))
(define S6 ((run S5 register) "user2"))

;iniciando sesión con usuarios. Incluye caso S8 que intenta iniciar sesión con user2 sin antes haber salido con user1
(define S7 ((run S6 login) "user1"))
(define S8 ((run S7 login) "user2"))

;cerrando sesión user1 e iniciando con user2
(define S9 (run S8 logout))
(define S10 ((run S9 login) "user2"))

;cambios de unidad, incluyendo unidad inexistente K
(define S11 ((run S10 switch-drive) #\K))
(define S12 ((run S11 switch-drive) #\C))

;añadiendo carpetas. Incluye casos de carpetas duplicadas.
(define S13 ((run S12 md) "folder1"))
(define S14 ((run S13 md) "folder2"))
(define S15 ((run S14 md) "folder2"))
(define S16 ((run S15 md) "folder3"))

;ingresa a carpeta folder2
(define S17 ((run S16 cd) "folder2"))

;crea subcarpeta folder21 dentro de folder2 (incluye caso S19 de carpeta con nombre duplicado)
(define S18 ((run S17 md) "folder21"))
(define S19 ((run S18 md) "folder21"))

;ingresa a subcarpeta e intenta ingresar a subcarpeta inexistente S21
(define S20 ((run S19 cd) "folder21"))
(define S21 ((run S20 cd) "folder22"))

;vuelve a carpeta anterior
(define S22 ((run S21 cd) ".."))

;vuelve a ingresar folder21
(define S23 ((run S22 cd) "folder21"))

;crea subcarpeta folder211 e ingresa
(define S24 ((run S23 md) "folder211"))
(define S25 ((run S24 cd) "folder211"))

;vuelve a la raíz de la unidad c:/
(define S26 ((run S24 cd) "/"))

;se cambia de unidad
(define S27 ((run S26 switch-drive) #\D))

;crea carpeta e ingresa a carpeta
(define S28 ((run S27 md) "folder5"))
(define S29 ((run S28 cd) "folder5"))

;se cambia de carpeta en base a la ruta especificada
(define S30 ((run S29 cd) "C:/folder1/"))

;; OBSERVACIÓN DEL ESTUDIANTE: Se deja comentada esta sección debido a que no se realiza la función "format"

;formateando drive D: 
;(define S31 ((run S30 format) #\D "newD"))

;añadiendo archivos

;; OBSERVACIÓN DEL ESTUDIANTE: Se sabe que no se debe modificar el script de pruebas del enunciado pero Scheme posee  una
;; función predeterminada llamada "file" lo cuál genera conflicto con la solución diseñada por el estudiante, por lo que
;; el TDA file diseñado por el estudiante se nombró filee(se añadió una e al final), por lo que, se hizo ese ajuste en las
;; pruebas debajo este comentario.

(define S32 ((run S30 add-file) (filee "foo1.txt" "txt" "hello world 1")))
(define S33 ((run S32 add-file) (filee "foo2.txt" "txt" "hello world 2")))
(define S34 ((run S33 add-file) (filee "foo3.docx" "docx" "hello world 3")))
;;(define S35 ((run S34 add-file) (filee "goo4.docx" "docx" "hello world 4" \#h \#r))) ;con atributos de seguridad oculto (h) y de solo lectura (r)

;eliminando archivos
(define S36 ((run S34 del) "*.txt"))
(define S37 ((run S34 del) "f*.docx"))
(define S38 ((run S34 del) "goo4.docx"))
(define S39 ((run S34 cd) ".."))
(define S40 ((run S34 del) "folder1"))

;borrando una carpeta
(define S41 ((run S39 rd) "folder1"))  ;no debería borrarla, pues tiene archivos
(define S42 ((run S41 cd) "folder1"))
(define S43 ((run S42 del) "*.*"))
(define S44 ((run S43 cd) ".."))
(define S45 ((run S44 rd) "folder1"))

;copiando carpetas y archivos
(define S46 ((run S34 copy) "foo1.txt" "c:/folder3/"))
(define S47 ((run S46 cd) ".."))
(define S48 ((run S47 copy) "folder1" "d:/"))
#|
;moviendo carpetas y archivos
(define S49 ((run S48 move) "folder3" "d:/"))
(define S50 ((run S49 cd) "folder1"))
(define S51 ((run S50 move) "foo3.docx" "d:/folder3/"))

;renombrando carpetas y archivos
(define S52 ((run S51 ren) "foo1.txt" "newFoo1.txt"))
(define S53 ((run S52 ren) "foo2.txt" "newFoo1.txt")) ;no debería efectuar cambios pues ya existe archivo con este nombre
(define S54 ((run S53 cd) ".."))
(define S55 ((run S54 ren) "folder1" "newFolder1"))

;listando la información
(display (run S16 dir))
(display (run S55 dir))
(display ((run S55 dir) "/s")) ;muestra carpetas y subcarpetas de la unidad C
(display ((run S55 dir) "/s /a")) ;muestra todo el contenido de carpetas y subcarpetas de la unidad C incluyendo archivo oculto goo4.docx

;encriptando archivos y carpetas
(define S56 ((run S55 encrypt) plus-one minus-one "1234" "newFolder1"))
(define S57 ((run S56 switch-drive) \#D))
(define S58 ((run S57 cd) "folder3"))
(define S59 ((run S58 encrypt) plus-one minus-one "4321" "foo3.docx"))

;desencriptando archivos y carpetas
(define S60 ((run S59 decrypt) "1234" "foo3.docx")) ;no logra desencriptar por clave incorrecta
(define S61 ((run S60 decrypt) "4321" "foo3.docx"))
(define S62 ((run S61 switch-drive) \#C)
(define S63 ((run S62 decrypt) "1234" "newFolder1"))

;;buscando contenido
(define S64 ((run S63 cd) "newFolder1"))
(display ((run S64 grep) "hello" "newFoo1.txt"))
(display ((run S64 grep) "hello" "*.*"))

;viendo la papelera
(display (run S45 viewTrash))

;restaurando
(define S65 ((run S45 restore) "folder1"))
|#

#|
Iniciar su nuevas pruebas:
|#

;(define Sys0 (system "Sistema pruebas Informe"))