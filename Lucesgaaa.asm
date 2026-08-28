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
; DIRECTIVAS DE INCLUSI?N
;===============================================================================
LIST P=16F887			
#include "p16f887.inc"	
	
;===============================================================================
; CONFIGURACI?N GENERAL DEL MCU
;=============================================================================== 	
__CONFIG _XT_OSC, _WDTE_OFF, _MCLRE_ON, _LVP_OFF
;===============================================================================
; DEFINICI?N DE CONSTANTES
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
; DEFINICI?N DE VARIABLES
;=============================================================================== 
    CBLOCK 0X20
    DELAY1
    DELAY2
    DELAY3
    COUNTER_LED
    COUNTER_SECUENCES
    ENDC
;===============================================================================
; DECLARACI?N DE MACROS PARA CONFIGURACI?N DE REGISTROS
;===============================================================================
CFG_SWITCH MACRO
    BANKSEL ANSEL
    BCF	     ANSEL, 5
    
    BANKSEL TRISE
    BSF	     TRISE, 0

    BANKSEL PORTE
    BCF     SWITCH
ENDM
CFG_DIGITS_DSPL MACRO
ENDM
DSPL_ALL_OFF MACRO
ENDM
CFG_LEDS MACRO
    BANKSEL TRISD
    CLRF    TRISD
    
    BANKSEL PORTD
    CLRF    PORTD
ENDM
LEDS_ON MACRO
    BANKSEL PORTD
    MOVLW b'11111111'
    MOVWF PORTD
ENDM
LEDS_OFF MACRO
    BANKSEL PORTD
    CLRF    PORTD
ENDM
LEDS_RLF MACRO
ENDM
LEDS_RRF MACRO
ENDM
CFG_BUZZER MACRO
    BANKSEL TRISC
    BCF     BUZZER
    
    BANKSEL PORTD
    BCF     BUZZER
ENDM
BUZZER_ON MACRO
    BANKSEL PORTC
    BSF     BUZZER
ENDM
BUZZER_OFF MACRO
    BANKSEL PORTC
    BCF     BUZZER
ENDM
CFG_DELAY_100MS MACRO
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
CFG_DELAY_200MS MACRO
    CFG_DELAY_100MS
    CFG_DELAY_100MS
ENDM
CFG_DELAY_300MS MACRO
    CFG_DELAY_200MS
    CFG_DELAY_100MS
ENDM
CFG_DELAY_1s MACRO
    CFG_DELAY_300MS
    CFG_DELAY_300MS
    CFG_DELAY_300MS
    CFG_DELAY_100MS
ENDM
CFG_SECUENCES MACRO	;4 SECUENCIAS
    
ENDM
;===============================================================================
; INICIALIZACI?N DEL MCU (C?DIGO ABSOLUTO)
;===============================================================================    
    ORG     0x00	;Vector de Reset
    GOTO    INICIO	;Salto al inicio del programa principal
    ORG     0x05	;Ubicaci?n Programa Principal en la memoria 
			;de programa
;===============================================================================
; INICIALIZACI?N DE MACROS PARA CONFIGURACI?N DE REGISTROS
;===============================================================================    	    

;===============================================================================
; INICIO PROGRAMA PRINCIPAL
;===============================================================================						
INICIO			
   

MAIN_LOOP
   
   GOTO MAIN_LOOP
	
;===============================================================================
; SUBRUTINAS
;===============================================================================	 
;***************************
; @brief    LOOP DE UNA CANTIDAD DE CICLOS PARA GENERAR UN DELAY
;           
; @details  MUEVO VALORES ESTABLECIDOS DE CANTIDAD DE CICLOS A LA VARIABLE DE
;	    DE CONTAR (A TRAVEZ DE W) Y LUEGO LA USO PARA UN LOOP QUE CUENTA 
;	    LA CANTIDAD DE CICLOS. UNA VEZ TERMINADO EL LOOP, VUELVE A AL
;	    MAIN LOOP. USO 2 NOP PARA AJUSTAR Y QUE QUEDE EXACTAMENTE 1 ms
;*************************** 

RETURN			; (2 ciclos)
;===============================================================================		
    END
;===============================================================================