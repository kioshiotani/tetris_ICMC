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
	loadn r0, #319 ; posicao inicial da peca

	call imprime_mapa
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
desenha_L
	


