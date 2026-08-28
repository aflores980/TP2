;===============================================================================
; @file       TP2.asm
;
; @author     
;
; @date       20/08/2026
;
; @version    0.1
;===============================================================================

;===============================================================================
; DIRECTIVAS DE INCLUSION
;===============================================================================
LIST P=16F887			
#include "p16f887.inc"	
	
;===============================================================================
; CONFIGURACION GENERAL DEL MCU
;=============================================================================== 	
__CONFIG _XT_OSC, _WDTE_OFF, _MCLRE_ON, _LVP_OFF
;===============================================================================
; DEFINICION DE CONSTANTES
;===============================================================================     
#DEFINE BUZZER	PORTC, 0
    
#DEFINE SWITCH	PORTE, 0

#DEFINE LED0	PORTD, 0
#DEFINE LED1	PORTD, 1
#DEFINE LED2	PORTD, 2
#DEFINE LED3	PORTD, 3
#DEFINE LED4	PORTD, 4
#DEFINE LED5	PORTD, 5
#DEFINE LED6	PORTD, 6
#DEFINE LED7	PORTD, 7
    
DELAY1_Init	EQU .64
DELAY2_Init	EQU .51
DELAY3_Init	EQU .10
;===============================================================================
; DEFINICION DE VARIABLES
;=============================================================================== 
    CBLOCK 0X20
    DELAY1
    DELAY2
    DELAY3
    COUNTER_LED
    COUNTER_SECUENCES
    ENDC
;===============================================================================
; DECLARACION DE MACROS PARA CONFIGURACION DE REGISTROS
;===============================================================================
CFG_SWITCH MACRO      ;Seteo de el puerto 5 ansel a salida digital, esto para el pulsador.
    BANKSEL ANSEL
    BCF	     ANSEL, 5
    
    BANKSEL TRISE
    BSF	     TRISE, 0

    BANKSEL PORTE
    BCF     SWITCH
ENDM

;Este trabajo práctico carece de Display, por lo que no se hace nada en nunguna de estas macros.
CFG_DIGITS_DSPL MACRO 
ENDM
DSPL_ALL_OFF MACRO
ENDM

CFG_LEDS MACRO       ;Seteo para que los leds empiecen desactivados.
    BANKSEL TRISD
    CLRF    TRISD
    
    BANKSEL PORTD
    CLRF    PORTD
ENDM

LEDS_ON MACRO        ;Seteo para que todos los leds se enciendan.
    BANKSEL PORTD
    MOVLW b'11111111'
    MOVWF PORTD
ENDM

LEDS_OFF MACRO       ;Seteo para que todos los leds se apaguen.
    BANKSEL PORTD
    CLRF    PORTD
ENDM

LEDS_RLF MACRO
ENDM

LEDS_RRF MACRO
ENDM

CFG_BUZZER MACRO     ;Asignacion de buzzer como salida en el puerto C en estado apagado.
    BANKSEL TRISC
    BCF     BUZZER
    
    BANKSEL PORTC
    BCF     BUZZER
ENDM

BUZZER_ON MACRO      ;Enciende el buzzer.
    BANKSEL PORTC
    BSF     BUZZER
ENDM

BUZZER_OFF MACRO     ;Apaga el buzzer
    BANKSEL PORTC
    BCF     BUZZER
ENDM

CFG_DELAY_100MS MACRO    ;Genera un delay de 100ms.
    LOCAL OUTER_LOOP, MIDDLE_LOOP, INSIDE_LOOP
    MOVLW   DELAY3_Init
    MOVWF   DELAY3
    OUTER_LOOP
	MOVLW	DELAY2_Init
	MOVWF	DELAY2
	MIDDLE_LOOP
	    MOVLW   DELAY1_Init
	    MOVWF   DELAY1
	    INSIDE_LOOP
		DECFSZ	DELAY1
		GOTO	INSIDE_LOOP
	    DECFSZ  DELAY2
	    GOTO    MIDDLE_LOOP
	DECFSZ	DELAY3
	GOTO	OUTER_LOOP
ENDM

CFG_DELAY_200MS MACRO ;Simplemente llama 2 veces la macro CFG_DELAY_100MS para generar un delay de 200ms.
    CFG_DELAY_100MS
    CFG_DELAY_100MS
ENDM

CFG_DELAY_300MS MACRO ;Llama 2 macros para generar un delay de 300ms.
    CFG_DELAY_200MS
    CFG_DELAY_100MS
ENDM
CFG_DELAY_1s MACRO   ;Finalmente, llama utilizando las otras macros para generar un delay de 1s.
    CFG_DELAY_300MS
    CFG_DELAY_300MS
    CFG_DELAY_300MS
    CFG_DELAY_100MS
ENDM
CFG_SECUENCES MACRO	 ;4 secuencias.
    
ENDM
;===============================================================================
; INICIALIZACI?N DEL MCU (CODIGO ABSOLUTO)
;===============================================================================    
    ORG     0x00	;Vector de Reset
    GOTO    INICIO	;Salto al inicio del programa principal
    ORG     0x05	;Ubicaci?n Programa Principal en la memoria 
			;de programa
;===============================================================================
; INICIALIZACION DE MACROS PARA CONFIGURACI?N DE REGISTROS
;===============================================================================    	    

;===============================================================================
; INICIO PROGRAMA PRINCIPAL
;===============================================================================						
INICIO			
   

MAIN_LOOP
	TEST_LEDS      ;Estado neutro de los leds mientras no se precione el pulsador (se encienden y apagan con intervalos de 1s)
		CFG_DELAY_1s
		LEDS_ON
		DELAY_3LOOP
		LEDS_OFF
		DELAY3_LOOP
	BTFSC BUZZER
	GOTO SECUENCIA
	GOTO MAIN_LOOP
	
;===============================================================================
; SUBRUTINAS
;===============================================================================

BUZZER_BIP	;completar mapa primero

FORWARD_LED					;Leds se prenden uno a uno de izq a der
STC							;Flag de carry en 1
FW_LOOP
	LEDS_RLF				;Movimiento de leds izq a der
	DELAY_3LOOP
	BTFSS LED7				;Revisa si el led 7 está en 1 para ver si terminó la secuencia
RETURN

BACKWARD_LED				;Leds se prenden uno a uno de der a izq
CLC							;Flag de carry en 0
BW_LOOP
	LEDS_RRF				;Movimiento de leds izq a der
	DELAY_3LOOP
	BTFSS LED0				;Revisa si el led 0 está en 1 para ver si terminó la secuencia
RETURN

PROGRESSIVE_LED_ON	;completar mapa primero

PROGRESSIVE_LED_OFF ;completar mapa primero

RUNNING_LIGHT
CFG_DELAY_300ms					;Configura tiempo de delay de DELAY_3LOOP
LEDS_OFF
LOOP_RL
	FORWARD_LED
	DCFSZ COUNTER_SEQUENCES		;cantidad de repeticiones de la accion anterior
	GOTO LOOP_RL
CFG_SEQUENCES					;reconfigura variables que necesitan las secuencias
RETURN

BIDIR_RUNNING_LIGHT
CFG_DELAY_200ms
LEDS_OFF
LOOP_BRL
	FORWARD_LED
	BACKWARD_LED
	DECFSZ COUNTER_SEQUENCES	;cantidad de repeticiones de la accion anterior
CFG_SEQUENCES					;reconfigura variables que necesitan las secuencias
RETURN

CRAWLING
CFG_DELAY_100ms
LEDS_OFF
LOOP_CW
	PROGRESSIVE_LED_ON
	PROGRESSIVE_LED_OFF
	DECFSZ COUNTER_SEQUENCES	;cantidad de repeticiones de la accion anterior
CFG_SEQUENCES					;reconfigura variables que necesitan las secuencias
RETURN

;***************************
; @brief    LOOP DE UNA CANTIDAD DE CICLOS PARA GENERAR UN DELAY
;           
; @details  MUEVO VALORES ESTABLECIDOS DE CANTIDAD DE CICLOS A LA VARIABLE DE
;	    DE CONTAR (A TRAVEZ DE W) Y LUEGO LA USO PARA UN LOOP QUE CUENTA 
;	    LA CANTIDAD DE CICLOS. UNA VEZ TERMINADO EL LOOP, VUELVE A AL
;	    MAIN LOOP. USO 2 NOP PARA AJUSTAR Y QUE QUEDE EXACTAMENTE 1 ms
;*************************** 
SECUENCIA

RETURN			; (2 ciclos)
;===============================================================================		
    END
;===============================================================================
