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
; DIRECTIVAS DE INCLUSIÓN
;===============================================================================
LIST P=16F887			
#include "p16f887.inc"	
	
;===============================================================================
; CONFIGURACIÓN GENERAL DEL MCU
;=============================================================================== 	
__CONFIG _XT_OSC, _WDTE_OFF, _MCLRE_ON, _LVP_OFF
;===============================================================================
; DEFINICIÓN DE CONSTANTES
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
;===============================================================================
; DEFINICIÓN DE VARIABLES
;=============================================================================== 
    CBLOCK 0X20
    DELAY1_Init
    DELAY2_Init
    DELAY3_Init
    DELAY1
    DELAY2
    DELAY3
    COUNTER_LED
    COUNTER_SECUENCES
    ENDC
;===============================================================================
; DECLARACIÓN DE MACROS PARA CONFIGURACIÓN DE REGISTROS
;===============================================================================
CFG_SWITCH MACRO
    BANKSEL ANSEL
    BCF	    ANSEL, 5
    
    BANKSEL TRISE
    BSF	    TRISE, 0
ENDM
CFG_DIGITS_DSPL MACRO
ENDM
DSPL_ALL_OFF MACRO
ENDM
CFG_LEDS MACRO
ENDM
LEDS_ON MACRO
ENDM
LEDS_OFF MACRO
ENDM
LEDS_RLF MACRO
ENDM
LEDS_RRF MACRO
ENDM
CFG_BUZZER MACRO
ENDM
BUZZER_ON MACRO
ENDM
BUZZER_OFF MACRO
ENDM
CFG_DELAY_100MS MACRO
ENDM
CFG_DELAY_200MS MACRO
ENDM
CFG_DELAY_300MS MACRO
ENDM
CFG_DELAY_1s MACRO
ENDM
CFG_SECUENCES MACRO
ENDM
;===============================================================================
; INICIALIZACIÓN DEL MCU (CÓDIGO ABSOLUTO)
;===============================================================================    
    ORG     0x00	;Vector de Reset
    GOTO    INICIO	;Salto al inicio del programa principal
    ORG     0x05	;Ubicación Programa Principal en la memoria 
			;de programa
;===============================================================================
; INICIALIZACIÓN DE MACROS PARA CONFIGURACIÓN DE REGISTROS
;===============================================================================    	    

;===============================================================================
; INICIO PROGRAMA PRINCIPAL
;===============================================================================						
INICIO			
   ; --- CONFIGURACIÓN DEL PUERTO D ---
   CONFIG_PORTD

MAIN_LOOP
   
   GOTO MAIN_LOOP
	
;===============================================================================
; SUBRUTINAS
;===============================================================================	 
;*******************************************************************************
; @brief    LOOP DE UNA CANTIDAD DE CICLOS PARA GENERAR UN DELAY
;           
; @details  MUEVO VALORES ESTABLECIDOS DE CANTIDAD DE CICLOS A LA VARIABLE DE
;	    DE CONTAR (A TRAVEZ DE W) Y LUEGO LA USO PARA UN LOOP QUE CUENTA 
;	    LA CANTIDAD DE CICLOS. UNA VEZ TERMINADO EL LOOP, VUELVE A AL
;	    MAIN LOOP. USO 2 NOP PARA AJUSTAR Y QUE QUEDE EXACTAMENTE 1 ms
;******************************************************************************* 

RETURN			; (2 ciclos)
;===============================================================================		
    END
;===============================================================================