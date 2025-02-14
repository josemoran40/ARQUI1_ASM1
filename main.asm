
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
 rb db 'RB|','$'
 rn db 'RN|','$'
 vacio db '  |','$'
 salto db 0ah,0dh,'$'
 letras db '   A  B  C  D  E  F  G  H ',0ah,0dh,'$'
 msmError2 db 0ah,0dh,'Error al leer archivo','$'
 msmError3 db 0ah,0dh,'Error al crear archivo','$'
 msmError4 db 0ah,0dh,'Error al Escribir archivo','$'
 htmlopen db '<html><head><link rel="stylesheet" href="style.css"></head><body style="background-color: #393939">',0ah,0dh
 htmlclose db '</body></html>',0ah,0dh
 htmltable db '<center><table>',0ah,0dh
 htmltablecl db '</center></table>',0ah,0dh
 htmltr db '<tr style="width:80; height:80">',0ah,0dh
 htmltrcl db '</tr>',0ah,0dh
 htmltd db '<td>'
 htmltdcl db '</td>',0ah,0dh
 htmlvacio db '<img src = "P1/gris.png">'
 htmlblanca db '<img src = "P1/blanca.png">'
 htmlnegra db '<img src = "P1/negra.png">'
 htmlReinaNegra db '<img src = "P1/reinanegra.png">'
 htmlReinaBlanca db '<img src = "P1/reinablanca.png">'
 htmlceleste db '<img src = "P1/celeste.png">'
 htmlh1 db '<center><h1 style="color:white">'
 htmlh1cl db '</h1></center>'
 msgjugador1 db 'Turno de fichas blancas',0ah,0dh,'$'
 msgjugador2 db 'Turno de fichas negras',0ah,0dh,'$'
 errormov db 'Error no se puede realizar el movimiento',0ah,0dh,'$'
 saltoLinea db 0ah,0dh,'$'
 htmlmsg db 'Archivo html generado correctamente',0ah,0dh,'$'
 savemsg db 'Archivo guardado correctamente',0ah,0dh,'$'
 juegoTerminado db 'Juego terminado', 0ah,0dh,'$'
 datosJose db 'JOSE EDUARDO MORAN REYES 201807455'
 cargaBlanca db '1'
 cargaNegro db '2'
 cargaVacio db '3'
 cargaIndefinida db '4'
 cargaReinaBlanca db '5'
 cargaReinaNegro db '6'
 pedirRuta db 'Ingrese el nombre del archivo:',0ah,0dh,'$'
bufferJuego db '1','$'

row1 db 000, 011, 000, 011, 000, 011, 000, 011
row2 db 011, 000, 011, 000, 011, 000, 011, 000
row3 db 000, 011, 000, 011, 000, 011, 000, 011
row4 db 001, 000, 001, 000, 001, 000, 001, 000
row5 db 000, 001, 000, 001, 000, 001, 000, 001
row6 db 100, 000, 100, 000, 100, 000, 100, 000
row7 db 000, 100, 000, 100, 000, 100, 000, 100  ; coronar blanca 010
row8 db 100, 000, 100, 000, 100, 000, 100, 000 ; coronar negra 111
bufferTemporal db 6 dup('$')
bufferLectura db 6 dup('$')
bufferLecturaCarga db 10 dup('$')
bufferFecha db 12 dup('-')
bufferHora db 8 dup(':')
rutaArchivo db 'reporte.html',00h
bufferEscritura db 200 dup('$')
handleFichero dw ?
handleCarga dw ?

rutaCarga db 200 dup(0),0
leerCarga db 200 dup(0),0

.code 
;================== SEGMENTO DE CODIGO ===========================
	main proc		
        print intro
        print intro2
        MENU:
        print opciones
            getChar
            cmp al,49
            je OPCION1
            cmp al,50
            je OPCION2
            cmp al,51
            je SALIR
            jmp MENU 

        OPCION1:
            print saltoLinea
            iniciarJuego
            jmp MENU           
        OPCION2:
            print pedirRuta
            getTexto leerCarga
            cargaTablero leerCarga, handleCarga, bufferLecturaCarga  
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
        CloseError:
            print errorclosef
            jmp Initprogram  
		SALIR: 
			MOV ah,4ch
			int 21h
	main endp
end


