#lang racket
(require (file "requerimientosFuncionales.rkt"))
(require (file "system.rkt"))
(require (file "filee.rkt"))
#|
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
  |   definidas bajo comentarios de dos      |
  |   puntos y comas, es decir, ;;texto.     |
  |   Serán las funciones definidas por el   |
  |   estudiante.                            |
  |                                          |
  |------------------------------------------|
|#

;; mis ejemplos

(display "Campo de pruebas: \n")
(define S0(system "Kali Linux"))
S0
(define S1((run S0 add-drive)#\C "Drive1" 2424))
S1 
(define S2((run S1 register)"Flash"))
S2 
(define S3((run S2 register)"Batman"))
S3 
(define S4((run S3 add-drive)#\D "Drive2" 1000))
S4 
(define S5((run S4 register)"Robin"))
S5 
(define S6((run S5 login)"Batman"))
S6 
(define S7((run S6 switch-drive)#\C))
S7 
(define S8((run S7 switch-drive)#\D))
S8 
(define S9((run S8 md)"NewMd"))
S9 
(define S10((run S9 md)"LAB-PDP"))
S10 
(define S11((run S10 switch-drive)#\C))
S11
(define S12((run S11 md)"LAB-PDP2"))
S12
(define S13((run S12 cd)"LAB-PDP2"))
S13
(define S14((run S13 md)"Wallpapers"))
S14
(define S15((run S14 cd)"Wallpapers"))
S15
(define S16((run S15 cd)".."))
S16
(define F1(filee "Texto Calculo" ".txt" "En este texto..."))
F1
(define F2(filee "Drake - Jungle" ".mp3" "These days, im lettin god..."))
(define F3(filee "Informe paradigmas" ".txt" "Laboratorio N°1"))
(define S17((run S16 add-file)F1))
S17
(define S18((run S17 add-file)F2))
S18
(define S19((run S18 cd)"LAB-PDP2/Wallpapers"))
S19
(define S20((run S19 add-file)F3))
S20 
(define S21((run S20 copy) "Wallpapers" "d:/"))
S21 #|
|#