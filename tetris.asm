jmp main

;desenhos

; $ = quadrado vazio
; # = quadrado cheio

;mapa do tetris
mapa0  : string "                                        " 
mapa1  : string "                                        " 
mapa2  : string "                                        " 
mapa3  : string "                                        " 
mapa4  : string "                                        " 
mapa5  : string "               $$$$$$$$$$               " 
mapa6  : string "               $$$$$$$$$$               " 
mapa7  : string "               $$$$$$$$$$               " 
mapa8  : string "               $$$$$$$$$$               " 
mapa9  : string "               $$$$$$$$$$               " 
mapa10 : string "               $$$$$$$$$$               " 
mapa11 : string "               $$$$$$$$$$               " 
mapa12 : string "               $$$$$$$$$$               " 
mapa13 : string "               $$$$$$$$$$               " 
mapa14 : string "               $$$$$$$$$$               " 
mapa15 : string "               $$$$$$$$$$               " 
mapa16 : string "               $$$$$$$$$$               " 
mapa17 : string "               $$$$$$$$$$               " 
mapa18 : string "               $$$$$$$$$$               " 
mapa19 : string "               $$$$$$$$$$               " 
mapa20 : string "               $$$$$$$$$$               " 
mapa21 : string "               $$$$$$$$$$               " 
mapa22 : string "               $$$$$$$$$$               " 
mapa23 : string "               $$$$$$$$$$               " 
mapa24 : string "               $$$$$$$$$$               " 
mapa25 : string "                                        " 
mapa26 : string "                                        " 
mapa27 : string "                                        " 
mapa28 : string "                                        " 
mapa29 : string "                                        "

main:
	loadn r0, #220 ; posicao inicial da peca


	call imprime_mapa
	
	call desenha_L
	halt

;----------------------------------------------------------
;Imprime mapa
;----------------------------------------------------------
imprime_mapa:
	;Tela: 40x30 (largura x altura)
	push r1
	push r5
	push r2
	push r3

	loadn r1, #mapa0 ;primeira linha do mapa
	loadn r5, #0 ;posicao inicial da primeira linha
	loadn r2, #40 ;r2 <- 40
	loadn r3, #1200 ;r3 <- 1200
	loadn r4, #41 ;r4 <- 41
	
	loop_imprime_mapa:
		call imprime_linha
		add r1, r1, r4 ;apontar para a proxima linha do mapa
		add r5, r5, r2 ;apontar para a posicao inicial da proxima linha
		cmp r5, r3 ;verificar se ultrapassou o limite da tela
		jne loop_imprime_mapa
	
	pop r3
	pop r2
	pop r5
	pop r1	
	rts


;----------------------------------------------------------
;Fim imprime_mapa
;---------------------------------------------------------
		
;-----------------------------------------------------------
;Imprime Linha
;-----------------------------------------------------------
;argumentos:
;r1 = endereco inicial da string
;r5 = posicao inicial da linha
imprime_linha:
	;pushs
	push r1 ;armazena o endereco da string inicial na pilha
	push r2 ;condicao de parada = fim da tela
	push r3 ;armazena char da linha
	push r4 ;contador, se 40, entao para	
	push r5 ;posicao atual da linha

	loadn r2, #40
	loadn r4, #0

	loop_imprime_linha:
		loadi r3, r1 ;Carrega o char
		outchar r3, r5	
		inc r1 ;r1 aponta para o proximo char
		inc r4 ;incrementa o contador
		inc r5 ;incrementa a posicao na linha
		cmp r4, r2 ;verifica condicao de parada se cont = 40
		jne loop_imprime_linha

	;pops
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	rts
;----------------------------------------------------------
;Fim imprime linha
;----------------------------------------------------------

;----------------------------------------------------------
;Desenhar L
;----------------------------------------------------------
desenha_L:
	;r0
	;r2
	;r3 r4

	push r1 ;armazena o char

	;posicoes das outras partes
	push r2
	push r3
	push r4

	;valores
	push r5
	loadn r5, #40
	
	;calculo da posicao dos quadradinhos
	add r2, r0, r5 ;r2 = r0 + 40
	add r5, r5, r5 ;r5 = 40 + 40
	add r3, r0, r5 ;r3 = r0 + 80
	inc r5 ;r5 = 81
	add r4, r0, r5
	
	loadn r1, #'#'
	
	outchar r1, r0
	outchar r1, r2
	outchar r1, r3
	outchar r1, r4

	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	
	rts
;----------------------------------------------------------
;FIM desenha L
;----------------------------------------------------------

;----------------------------------------------------------
;Delay
;----------------------------------------------------------
delay:
	push r7
	loadn r7, #6400

	delay_loop:
		dec r7
		jnz delay_loop
	
	pop r7
	rts
;----------------------------------------------------------
;FIM Delay
;----------------------------------------------------------

;----------------------------------------------------------
;apaga_L
;----------------------------------------------------------
apaga_L:
	;r0
	;r2
	;r3 r4

	push r1 ;armazena o char

	;posicoes das outras partes
	push r2
	push r3
	push r4

	;valores
	push r5
	loadn r5, #40
	
	;calculo da posicao dos quadradinhos
	add r2, r0, r5 ;r2 = r0 + 40
	add r5, r5, r5 ;r5 = 40 + 40
	add r3, r0, r5 ;r3 = r0 + 80
	inc r5 ;r5 = 81
	add r4, r0, r5
	
	loadn r1, #'$'
	
	outchar r1, r0
	outchar r1, r2
	outchar r1, r3
	outchar r1, r4

	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
;----------------------------------------------------------
;FIM apaga_L
;----------------------------------------------------------

;----------------------------------------------------------
;recalc_pos
;----------------------------------------------------------
;recalc_pos:

;----------------------------------------------------------
;FIM recalc_pos
;----------------------------------------------------------

	


