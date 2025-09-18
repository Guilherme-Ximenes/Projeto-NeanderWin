; ---------------------------------------------------------------------------------------
; Projeto: Calcular MDC entre dois números inteiros em 8 bits com algoritmo de Euclides 
; Autor: Guilherme Santana Bernardo Ximenes
; Data: 16/09/2025
; ---------------------------------------------------------------------------------------

; --INÍCIO---
        ORG 0           ; Ordena por onde será iniciado os primeiros passos no endereço de memória

; --- Ter a certeza que os valores de 'a' e 'b' são positivos  ---
        
;-- Para o número 'a'---;
        LDA 128         ; Guarda o valor de um conteúdo inserido na memória 128 (no caso, esse vai ser o 'a') do acumulador.
        JN A_NEGATIVO   ; Se o número for negativo, pula para o 'A_NEGATIVO'.
        STA NUM_A       ; Se for positivo, apenas salva temporariamente em 'NUM_A'.
        JMP PROCESS_B   ; Pula para o número 'b'.

A_NEGATIVO:             
        LDI 0           ; Coloca o número 0 imediatamente no acumulador.
        SUB 128         ; Aqui vai pegar o valor de 'a' que já estava na memória e subtrair de 0 que foi colocado imediatamente, ficando assim: 0 - (-a); Resultando em um número positivo.
        STA NUM_A       ; Salva o valor positivo agora de 'a' na variável 'NUM_A'.

; --- Para o número 'b'(mesma coisa do número 'a')--- 
PROCESS_B:
        LDA 129         ; Guarda o valor de b (definido na memória 129) no acumulador.
        JN B_NEGATIVO   ; Se for negativo, pula pro 'B_NEGATIVO'.
        STA NUM_B       ; Se positivo, salva na variável.
        JMP LOOP_AE     ; Pula para o início do algoritmo, aonde vai ser utilizado o método de Euclides para a resolução.

B_NEGATIVO:
        LDI 0           ; coloca o 0 imediatamente no acumulador.
        SUB 129         ; Pega o 'b' e subtrai do 0 pra dar um resultado positivo.
        STA NUM_B       ; Salva o novo valor positivo do 'b' na variável NUM_B.


; --- UTILIZANDO ALGORITMO DE EUCLIDES ---

LOOP_AE:
        LDA NUM_A          ; Carrega 'a' no acumulador.
        SUB NUM_B          ; Faz a operação a - b. 
        JZ FIM_FINALMENTE  ; Se o resultado for 0, acha o MDC e finaliza o processo
        JN A_MENOR_QUE_B   ; Se o resultado for negativo, pula para os casos.

;-Caso 1: a > b

        STA NUM_A       ; O acumulador já tem o resultado da operação a-b, então esse 'STA' vai pegar o valor da operação e substituir no 'NUM_A'
        JMP LOOP_AE     ; Em seguida, 'JMP' faz com que volte para o início do loop para comparar o novo valor de 'a' com o 'b' já presente 

;-Caso 2: a < b

A_MENOR_QUE_B:
        LDA NUM_B       ; O acumulador tem 'a-b', mas como não serve nesse caso, o 'LDA' vai recarregar o valor de 'b' no acumulador novamente.
        SUB NUM_A       ; Calcula b - a agora.
        STA NUM_B       ; Atualiza NUM_B com o novo valor.
        JMP LOOP_AE     ; Volta pra o início do loop.


; --- FIM DO PROCESSO INTEIRO ---

FIM_FINALMENTE:
        LDA NUM_A       ; Pega o valor final de 'a', que vai ser igual a 'b', então tanto faz.
        STA 130         ; Armazena o resultado final no endereço de memória 130, é o Output. 
        OUT 0           ; Manda o valor do MDC para o visor.      
        HLT             ; Para a execução do programa.

        
; --- Variáveis ---
        ORG 131       ; Define um espaço reservado na memória para as variáveis abaixo.
NUM_A:    DS 1        ; Reserva 1 byte de espaço na memória pra variável 'a'.
NUM_B:    DS 1        ; Reserva 1 byte de espaço na memória pra variável 'b'.