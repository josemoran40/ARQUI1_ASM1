
include macros.asm

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
 msmError2 db 0ah,0dh,'Error al leer archivo','$'
 msmError3 db 0ah,0dh,'Error al crear archivo','$'
 msmError4 db 0ah,0dh,'Error al Escribir archivo','$'
 htmlopen db '<html><head><link rel="stylesheet" href="style.css"></head><body>',0ah,0dh
 htmlclose db '</body></html>',0ah,0dh
 htmltable db '<table>',0ah,0dh
 htmltablecl db '</table>',0ah,0dh
 htmltr db '<tr style="width:80; height:80">',0ah,0dh
 htmltrcl db '</tr>',0ah,0dh
 htmltd db '<td>'
 htmltdcl db '</td>',0ah,0dh
 htmlvacio db '<img src = "P1/gris.png">'
 htmlblanca db '<img src = "P1/blanca.png">'
 htmlnegra db '<img src = "P1/negra.png">'
 htmlceleste db '<img src = "P1/celeste.png">'
 msgjugador1 db 'Turno de jugador 1',0ah,0dh,'$'
 msgjugador2 db 'Turno de jugador 2',0ah,0dh,'$'
 errormov db 'Error no se puede realizar el movimiento',0ah,0dh,'$'
 saltoLinea db 0ah,0dh,'$'
 
 cargaBlanca db '1'
 cargaNegro db '2'
 cargaVacio db '3'
 cargaIndefinida db '4'
row1 db 000, 011, 000, 011, 000, 011, 000, 011
row2 db 011, 000, 011, 000, 011, 000, 011, 000
row3 db 000, 011, 000, 011, 000, 011, 000, 011
row4 db 001, 000, 001, 000, 001, 000, 001, 000
row5 db 000, 001, 000, 001, 000, 001, 000, 001
row6 db 100, 000, 100, 000, 100, 000, 100, 000
row7 db 000, 100, 000, 100, 000, 100, 000, 100
row8 db 100, 000, 100, 000, 100, 000, 100, 000
bufferTemporal db 6 dup('$')
bufferLectura db 6 dup('$')

rutaArchivo db 'reporte.html',00h
bufferEscritura db 200 dup('$')
handleFichero dw ?
handleCarga dw ?

rutaCarga db 'carga.txt',00h


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
            ;generarReporte htmlopen,htmlclose,htmltable,htmltablecl,htmltr,htmltrcl,htmltd,htmltdcl, rutaArchivo, handleFichero
            turnoJugador1
            printTablero
            turnoJugador2
            printTablero
            jmp MENU           
        OPCION2:
            print n2 
            jmp MENU
	    ErrorLeer:
	    	print msmError2
	    	getChar
	    	jmp MENU
	    ErrorCrear:
	    	print msmError3
	    	getChar
	    	jmp MENU
		ErrorEscribir:
	    	print msmError4
	    	getChar
	    	jmp MENU    
		SALIR: 
            generarCarga rutaCarga, handleCarga
			MOV ah,4ch
			int 21h
	main endp
end