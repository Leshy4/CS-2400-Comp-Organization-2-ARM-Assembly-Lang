;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; BASIC TEMPLATE
	   AREA    RESET, DATA, READONLY
          EXPORT  __Vectors
__Vectors 
              DCD  0x20001000 		; Stack Pointer Address	!!!
              DCD  Reset_Handler  	; reset vector
              ALIGN 
		
		AREA   CS2400_Fall2019, CODE, READONLY
    	ENTRY
   	      EXPORT Reset_Handler
Reset_Handler

;-----------------------------------------------------------------------------------------------------------------------------------------------------
;WRITE CODE BELOW THIS SECTION


	;CODE....


;-----------------------------------------------------------------------------------------------------------------------------------------------------
;CODE STOPS ABOVE THIS SECTION
;ALWAYS REQUIRE STOP
stop B stop
	END