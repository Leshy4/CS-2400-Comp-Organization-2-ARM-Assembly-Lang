;// Name, 900 number, Date, Time taken for doing the program, References.
						;Name:  Christopher Welch		;Date: 	04/04/20
						;Student #:900915317  			;Time: 	1 Hour	;References: Did it by Memory
	   AREA    RESET, DATA, READONLY
          EXPORT  __Vectors
__Vectors 
              DCD  0x20001000 
              DCD  Reset_Handler  ; reset vector
              ALIGN 		
		AREA   CS2400_Fall2019, CODE, READONLY
    	ENTRY
   	      EXPORT Reset_Handler
Reset_Handler
;;; // Use A	//Load R0 into R3	// #0d9915317 = #0x974BB5	 	
	LDR R0, A
	MOV R3, R0		;;Copy of A		
	MOV R1, #0x3FF	;;AND for 0-9	
	MOV R2, #0xFFF	;;AND for 0-11
	
	;;// Copy 1st 10 bits of the value stored in R3 into R5		
	AND R5,R0,R1		
	
	;;// Copy 10 bits from 11 to 20 to R6		
	LSR R0,#10
	AND R6,R0,R1		
	
	;;// Copy 12 bits 21 t0 32 in R7		
	LSR R0,#10
	AND R7,R0,R2			
	
	;// Store the values in a stack in the order R6, R5, R7
	STM SP, {R6,R5,R7}	

A DCD 0X974BB5
stop b stop 
		END		