;MACROS
print macro cadena ;print -> id del macro ;macro -> palabra reservada, representa al macro; cadena -> parámetro
LOCAL ETIQUETA ;LOCAL -> palabra reservada, representa la espera de una lista de etiquetas
ETIQUETA: ;etiqueta
	MOV ah,09h ;función para la impresión de cadenas
	MOV dx,@data ;lugar donde se ecuentra almacenados nuestros datos
	MOV ds,dx 
	MOV dx, offset cadena ;desplazamiento de la cadena de datos
	int 21h ;interrupción 21h
endm

getChar macro
mov ah,01h
int 21h
endm
;----------------------------- IMPRIMIR TABLERO ----------------------------------
printTablero macro
    print salto
    print n1
    printRow row1
    print salto
    print n2
    printRow row2
    print salto
    print n3
    printRow row3
    print salto
    print n4
    printRow row4
    print salto
    print n5
    printRow row5
    print salto
    print n6
    printRow row6
    print salto
    print n7
    printRow row7
    print salto
    print n8
    printRow row8
    print salto
    print letras 
endm

;------------------------- IMPRIMIR ARREGLO -------------------------------
printRow macro arreglo
LOCAL CICLO, printBlanca, printNegra, Afuera
mov cx,8
xor si,si
CICLO: 
    cmp arreglo[si],58h
    je printNegra
    cmp arreglo[si],57h
    je printBlanca
    print vacio
    jmp Afuera
    printBlanca:
        print fb
        jmp Afuera
    
    printNegra:
        print fn
    
    Afuera:
        inc si
LOOP CICLO
endm

;-------------------------LEER TEXTO ----------------------------------------------
getTexto macro buffer
    PUSH SI
    PUSH AX

    xor si,si
    CONTINUE:
    getChar
    cmp al,0dh
    je FIN
    mov buffer[si],al
    inc si
    jmp CONTINUE

    FIN:
    mov al,'$'
    mov buffer[si],al
    POP AX
    POP SI
endm

;-------------------------------------- JUEGO ---------------------------------------

turnoJugador1 macro 
LOCAL printBlanca, printNegra, Afuera
    getTexto bufferLectura;a2,b3
    accederFila bufferLectura
    pop dx
    mov ax, dx
    
    accederFila bufferLectura
    pop dx
    mov bx, dx
    cmp al,58h
    je printNegra
    cmp al,57h
    je printBlanca
    print vacio
    jmp Afuera
    printBlanca:
        print fb
        jmp Afuera
    
    printNegra:
        print fn
    
    Afuera:
    
endm


accederFila macro texto;xy
LOCAL f1,f2,f3,f4,f5,f6,f7, salir
    ;print fn      
    cmp texto[1], 49
    je f1
    cmp texto[1], 50
    je f2
    cmp texto[1], 51
    je f3
    cmp texto[1], 52
    je f4
    cmp texto[1], 53
    je f5
    cmp texto[1], 54
    je f6
    cmp texto[1], 55
    je f7
    print n8
    accederColumna texto, row8
    jmp salir
    f1:
    print n1
    accederColumna texto, row1
    jmp salir
    f2:
    print n2
    accederColumna texto, row2
    jmp salir
    f3:
    print n3
    accederColumna texto, row3
    jmp salir

    f4:
    print n4
    accederColumna texto, row4
    jmp salir

    f5:
    print n5
    accederColumna texto, row5
    jmp salir

    f6:
    print n6
    accederColumna texto, row6
    jmp salir

    f7:
    print n7
    accederColumna texto, row7
    jmp salir

    salir:
endm


accederColumna macro texto, fila
LOCAL f1,f2,f3,f4,f5,f6,f7, salir

    ;print fn
    xor dx,dx
    cmp texto[0], 65
    je f1
    cmp texto[0], 66
    je f2
    cmp texto[0], 67
    je f3
    cmp texto[0], 68
    je f4
    cmp texto[0], 69
    je f5
    cmp texto[0], 70
    je f6
    cmp texto[0], 71
    je f7
    print n8
    mov dl,fila[7]
    PUSH dx
    jmp salir
    f1:
    print n1    
    mov dl,fila[0]
    PUSH dx
    jmp salir
    f2:
    print n2
    mov dl,fila[1]
    PUSH dx
    jmp salir
    f3:
    print n3
    mov dl,fila[2]
    PUSH dx
    jmp salir

    f4:
    print n4
    mov dl,fila[3]
    PUSH dx
    jmp salir

    f5:
    print n5
    mov dl,fila[4]
    PUSH dx
    jmp salir

    f6:
    print n6
    mov dl,fila[5]
    PUSH dx
    jmp salir

    f7:
    print n7
    mov dl,fila[6]
    PUSH dx
    jmp salir

    salir:
endm

;------------------------ MAIN------------------------------------------------------

.model small
.stack 100h 
.data
;================ SEGMENTO DE DATOS ==============================
 intro db 'UNIVERSIDAD DE SAN CARLOS',0ah,0dh,'FACULTAD DE INGENIERIA',0ah,0dh,'CIENCIAS Y SISTEMAS',0ah,0dh,'$'
 intro2 db 'ARQUITECTURA DE COMPUTADORAS 1',0ah,0dh,'JOSE EDUARDO MORAN REYES',0ah,0dh,'201807455',0ah,0dh,'SECCION A',0ah,0dh,'$'
 opciones db 0ah,0dh,'1)Iniciar Juego',0ah,0dh,'2)Cargar Juego',0ah,0dh,'3)Salir',0ah,0dh,'$' 
 n1 db '1 ','$'
 n2 db '2 ','$'
 n3 db '3 ','$'
 n4 db '4 ','$'
 n5 db '5 ','$'
 n6 db '6 ','$'
 n7 db '7 ','$'
 n8 db '8 ','$'
 fb db 'FB|','$'
 fn db 'FN|','$'
 vacio db '  |','$'
 salto db 0ah,0dh,'$'
 letras db '   A  B  C  D  E  F  G  H ',0ah,0dh,'$'
row8 db 58h, 56h, 58h, 56h, 58h, 56h, 58h, 56h
row7 db 56h, 58h, 56h, 58h, 56h, 58h, 56h, 58h
row6 db 58h, 56h, 58h, 56h, 58h, 56h, 56h, 58h
row5 db 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h
row4 db 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h
row3 db 56h, 57h, 56h, 57h, 56h, 57h, 56h, 57h
row2 db 57h, 56h, 57h, 56h, 57h, 56h, 57h, 56h
row1 db 56h, 57h, 56h, 57h, 56h, 57h, 56h, 57h

bufferLectura db 5 dup('$')

.code 
;================== SEGMENTO DE CODIGO ===========================
	main proc		
        print intro
        print intro2
        print opciones
        MENU:
            getChar
            cmp al,49
            je OPCION1
            cmp al,50
            je OPCION2
            cmp al,51
            je SALIR
            jmp MENU 

        OPCION1:
            printTablero
            turnoJugador1
            jmp MENU           
        OPCION2:
            print n2 
            jmp MENU     
		SALIR: 
			MOV ah,4ch
			int 21h
	main endp
end