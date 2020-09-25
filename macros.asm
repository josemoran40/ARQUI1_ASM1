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
    cmp arreglo[si],100
    je printNegra
    cmp arreglo[si],011
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

turnoJugador2 macro 
LOCAL printBlanca, printNegra, Afuera, CONTINUAR, VERIFICAR2, VERIFICAR3,salir
    getTexto bufferLectura;a2,b3
    cmp bufferLectura[4],036
    je Menu

    accederFila bufferLectura, 4,3
    pop dx
    mov ax, dx
    cmp al, 001
    je VERIFICAR2
    jmp salir
    VERIFICAR2:
        accederFila bufferLectura, 1,0
        pop dx
        mov ax, dx
        cmp al, 100
        je VERIFICAR3
        jmp salir
    
    VERIFICAR3:
        xor ax, ax
        mov al,bufferLectura[1]
        mov ah,bufferLectura[4] 
        cmp al, ah    
        ja CONTINUAR
        jmp salir

    CONTINUAR:
        moverFicha bufferLectura, 4,3,100
        moverFicha bufferLectura, 1,0,001
        
    salir:

    jmp Menu
    

endm


accederFila macro texto, num1,num2
LOCAL f1,f2,f3,f4,f5,f6,f7, salir
    ;print fn    
    xor si,si
    mov si, num1  
    cmp texto[si], 49
    je f1
    cmp texto[si], 50
    je f2
    cmp texto[si], 51
    je f3
    cmp texto[si], 52
    je f4
    cmp texto[si], 53
    je f5
    cmp texto[si], 54
    je f6
    cmp texto[si], 55
    je f7
    accederColumna texto, row8,num2
    jmp salir
    f1:
    accederColumna texto, row1,num2
    jmp salir
    f2:
    accederColumna texto, row2,num2
    jmp salir
    f3:
    accederColumna texto, row3,num2
    jmp salir

    f4:
    accederColumna texto, row4,num2
    jmp salir

    f5:
    accederColumna texto, row5,num2
    jmp salir

    f6:
    accederColumna texto, row6,num2
    jmp salir

    f7:
    accederColumna texto, row7,num2

    salir:
endm


accederColumna macro texto, fila, num1
LOCAL f1,f2,f3,f4,f5,f6,f7, salir

    xor si,si
    mov si, num1
    xor dx,dx
    cmp texto[si], 65
    je f1
    cmp texto[si], 66
    je f2
    cmp texto[si], 67
    je f3
    cmp texto[si], 68
    je f4
    cmp texto[si], 69
    je f5
    cmp texto[si], 70
    je f6
    cmp texto[si], 71
    je f7
    mov dl,fila[7]
    PUSH dx
    jmp salir
    f1:    
    mov dl,fila[0]
    PUSH dx
    jmp salir
    f2:
    mov dl,fila[1]
    PUSH dx
    jmp salir
    f3:
    mov dl,fila[2]
    PUSH dx
    jmp salir

    f4:
    mov dl,fila[3]
    PUSH dx
    jmp salir

    f5:
    mov dl,fila[4]
    PUSH dx
    jmp salir

    f6:
    mov dl,fila[5]
    PUSH dx
    jmp salir

    f7:
    mov dl,fila[6]
    PUSH dx

    salir:
endm

;--------------------------MOVER FICHA -------------------------------------
moverFicha macro texto, num1,num2,valor
LOCAL f1,f2,f3,f4,f5,f6,f7, salir
    ;print fn    
    xor si,si
    mov si, num1  
    cmp texto[si], 49
    je f1
    cmp texto[si], 50
    je f2
    cmp texto[si], 51
    je f3
    cmp texto[si], 52
    je f4
    cmp texto[si], 53
    je f5
    cmp texto[si], 54
    je f6
    cmp texto[si], 55
    je f7
    print n8
    mover texto, row8,num2, valor
    jmp salir
    f1:
    print n1
    mover texto, row1,num2, valor
    jmp salir
    f2:
    print n2
    mover texto, row2,num2, valor
    jmp salir
    f3:
    print n3
    mover texto, row3,num2, valor
    jmp salir

    f4:
    print n4
    mover texto, row4,num2, valor
    jmp salir

    f5:
    print n5
    mover texto, row5,num2, valor
    jmp salir

    f6:
    print n6
    mover texto, row6,num2, valor
    jmp salir

    f7:
    print n7
    mover texto, row7,num2, valor

    salir:
endm


mover macro texto, fila, num1, valor
LOCAL f1,f2,f3,f4,f5,f6,f7, salir

    xor si,si
    mov si, num1
    xor dx,dx
    cmp texto[si], 65
    je f1
    cmp texto[si], 66
    je f2
    cmp texto[si], 67
    je f3
    cmp texto[si], 68
    je f4
    cmp texto[si], 69
    je f5
    cmp texto[si], 70
    je f6
    cmp texto[si], 71
    je f7
    print n8
    mov fila[7],valor
    jmp salir
    f1:   
    print n1 
    mov fila[0],valor
    jmp salir
    f2:
    print n2
    mov fila[1],valor
    jmp salir
    f3:
    print n3
    mov fila[2],valor
    jmp salir

    f4:
    print n4
    print n4
    mov fila[3],valor
    jmp salir

    f5:
    print n5
    mov fila[4],valor
    jmp salir

    f6:
    print n6
    mov fila[5],valor
    jmp salir

    f7:
    print n7
    mov fila[6],valor

    salir:
endm


;---------------------- REPORTE HTML -------------------------------
generarReporte macro htmlopen,htmlclose,htmltable,htmltablecl,htmltr,htmltrcl,htmltd,htmltdcl, rutaArchivo, handle
    crearArchivo rutaArchivo, handle
    abrirArchivo rutaArchivo, handle
    escribirArchivo SIZEOF htmlopen, htmlopen, handle
    escribirArchivo SIZEOF htmltable, htmltable, handle
    escribirArchivo SIZEOF htmltr, htmltr, handle
    generarFichas row1, handle
    escribirArchivo SIZEOF htmltrcl, htmltrcl, handle    
    escribirArchivo SIZEOF htmltr, htmltr, handle
    generarFichas row2, handle
    escribirArchivo SIZEOF htmltrcl, htmltrcl, handle
    escribirArchivo SIZEOF htmltr, htmltr, handle
    generarFichas row3, handle
    escribirArchivo SIZEOF htmltrcl, htmltrcl, handle
    escribirArchivo SIZEOF htmltr, htmltr, handle
    generarFichas row4, handle
    escribirArchivo SIZEOF htmltrcl, htmltrcl, handle
    escribirArchivo SIZEOF htmltr, htmltr, handle
    generarFichas row5, handle
    escribirArchivo SIZEOF htmltrcl, htmltrcl, handle
    escribirArchivo SIZEOF htmltr, htmltr, handle
    generarFichas row6, handle
    escribirArchivo SIZEOF htmltrcl, htmltrcl, handle
    
    escribirArchivo SIZEOF htmltr, htmltr, handle
    generarFichas row7, handle
    escribirArchivo SIZEOF htmltrcl, htmltrcl, handle
    
    escribirArchivo SIZEOF htmltr, htmltr, handle
    generarFichas row8, handle
    escribirArchivo SIZEOF htmltrcl, htmltrcl, handle
    escribirArchivo SIZEOF htmltablecl, htmltablecl, handle
    escribirArchivo SIZEOF htmlclose, htmlclose, handle

endm

generarFichas macro arreglo, handle
    LOCAL CICLO, printBlanca, printNegra,printCeleste, Afuera
    mov cx,8
    xor si,si
    CICLO: 
        escribirArchivo SIZEOF htmltd, htmltd, handle
        cmp arreglo[si],100
        je printNegra
        cmp arreglo[si],011
        je printBlanca
        cmp arreglo[si],000
        je printCeleste
        escribirArchivo SIZEOF htmlvacio, htmlvacio, handle
        jmp Afuera
        printBlanca:
            escribirArchivo SIZEOF htmlblanca, htmlblanca, handle
            jmp Afuera
        
        printNegra:
            escribirArchivo SIZEOF htmlnegra, htmlnegra, handle
            jmp Afuera
        printCeleste:
            escribirArchivo SIZEOF htmlceleste, htmlceleste, handle
        
        Afuera:
            escribirArchivo SIZEOF htmltdcl, htmltdcl, handle
        
        inc si
        dec cx
    JNE CICLO
endm


;----------------------- MOVIEMIENTO DE ARCHIVOS ----------------------
crearArchivo macro buffer,handle
    mov ah,3ch
    mov cx,00h
    lea dx,buffer
    int 21h
    jc ErrorCrear
    mov handle,ax
endm




escribirArchivo macro numbytes,buffer,handle
    push cx
    escribir numbytes,buffer,handle
    pop cx
endm


escribir macro numbytes,buffer,handle
	mov ah, 40h
	mov bx,handle
	mov cx,numbytes
	lea dx,buffer
	int 21h
	jc ErrorEscribir
endm

abrirArchivo macro ruta,handle
    mov ah,3dh
    mov al,10b
    lea dx,ruta
    int 21h
    mov handle,ax
    ;jc ErrorAbrir
endm
