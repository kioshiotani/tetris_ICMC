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
	loadn r7, #0 ; peca inicial = L

	call imprime_mapa

	main_loop:
		call desenha_L
		call delay
		call apaga_L
		call recalc_pos
		call mv_baixo
		jmp main_loop 	
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
	
	rts
;----------------------------------------------------------
;FIM apaga_L
;----------------------------------------------------------

;----------------------------------------------------------
;recalc_pos
;----------------------------------------------------------
recalc_pos:
	push r1 ;tecla apertada
	push r2 ;esquerda
	push r3 ;direita	

	inchar r1
	
	loadn r2, #'a'
	loadn r3, #'d'

	cmp r1, r2
	ceq mv_esq

	cmp r1, r3
	ceq mv_dir

	pop r3
	pop r2
	pop r1
	rts
;----------------------------------------------------------
;FIM recalc_pos
;----------------------------------------------------------

;----------------------------------------------------------
;mv_esq
;----------------------------------------------------------
mv_esq:
	push r1 ;r1 = 40
	push r2	;r2 usado para verificar qual e a peca
	push r3 ;usado para identificar a borda esquerda

	loadn r1, #40

	;verifica se e L em pe
	loadn r2, #0
	cmp r7, r2 ; Se r7 == 0	
	jeq mv_L_em_pe_esq
	
	mv_L_em_pe_esq:
		loadn r3, #15
		
		mod r1, r0, r1
		cmp r1, r3
		jeq mv_esq_fim
	
		;caso nao esteja na borda do mapa
		dec r0

	mv_esq_fim:
		pop r3
		pop r2
		pop r1
		rts

;----------------------------------------------------------
;FIM mv_esq
;----------------------------------------------------------

;----------------------------------------------------------
;mv_dir
;----------------------------------------------------------
mv_dir:
	push r1 ;r1 = 40
	push r2 ;r2 para verificar qual peca
	push r3 ;usado para identificar a borda direita

	loadn r1, #40	

	;verifica se e L em pe
	loadn r2, #0
	cmp r7, r2
	jeq mv_L_em_pe_dir
	
	mv_L_em_pe_dir:
	push r0 ;calcular a posicao da ponta do L
	;r0
	;r2
	;r3 ;r4
	
	;r0 = 81
	add r0, r0, r1 ; r0 += 40
	add r0, r0, r1 ; r0 += 40, 
	inc r0 ; r0++

	loadn r3, #24
	mod r1, r0, r1
	
	pop r0 ;recupera o valor original da posicao

	cmp r1, r3
	jeq mv_dir_fim

	;caso nao esteja na borda direita
	inc r0

	mv_dir_fim:
		pop r3
		pop r2
		pop r1
		rts
;----------------------------------------------------------
;FIM mv_dir
;----------------------------------------------------------

;----------------------------------------------------------
;mv_baixo
;----------------------------------------------------------
mv_baixo:
	push r2 ;r2 para verificar qual peca
	push r3 ;usado para identificar a borda de baixo
	push r5 ;aux
	push r4 ;usado para calcular outros quadradinhos das pecas

	;verifica se e L em pe
	loadn r2, #0
	cmp r7, r2
	jeq mv_L_em_pe_baixo
	
	mv_L_em_pe_baixo:
		;A
		;B
		;C ;D
		
		;calcular a posicao de C
		;r4 = r0 + 80, ou seja r4 = C
		loadn r5, #40
		add r4, r0, r5 ; r4 = r0 + 40
		add r4, r4, r5 ; r4 += 40 
		
		loadn r5, #975
		
		;verifica se e maior que 975
		cmp r4, r5
		jeg mv_baixo_fim	

	;caso nao esteja na borda de baixo
	loadn r5, #40
	add r0, r0, r5 ;r0 += 40 para descer

	mv_baixo_fim:
		pop r4
		pop r5	
		pop r3
		pop r2
		rts
;----------------------------------------------------------
;FIM mv_baixo
;----------------------------------------------------------


