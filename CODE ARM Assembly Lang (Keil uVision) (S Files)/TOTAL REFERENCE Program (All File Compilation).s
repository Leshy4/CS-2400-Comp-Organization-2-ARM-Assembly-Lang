
;;;; 			   PROGRAMMER:  Christopher Welch			DATES: ~2/20 - ~5/20
;;;;;;;;;;;;;;;;;; Purpose: FULL COMPILATION of ARM Assembly Language		Computer Organization II

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;;;;;;;;   ****** uVision Project == a Collection of S File(s) 
;;;;;;;;;;   ****** Connect to Specified Embedded System -> Build Code -> Debug Emulator (Can follow Values / Breakpoints) 
;;;;;;;;;;  		CONTAINS CODE FOR ->
;; Basic Entry Code / Branch Link / LR -> PC / Check String for Letter 'H'
;; Flags / Math / Factorial ( Nieve -> Modified -> Link Register (LR) to fill the Program Counter (PC))
;; Arrays / Address Incrementation (Find Value in Array) 
;; Memory (Retrieval & Storage) / Suffixes / Floating Point Operations / Swap Contents with (E)OR(R) Or Exclusiv
;; Load/Store Memory Base Update/Unchanged (LDM/STM) / Name Length / 
;; OddSum (Read Array & Sum += Only Odd Numbers & Store in R3) / Nested Function Calls 
;; Arithmetic Shift Right & Rotate Right / Copy Bits & Bit Masking (Final Code Exam)
;; Parity Bit
;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~STANDARD BEGINNING CODE (Start)~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	   AREA    RESET, DATA, READONLY
          EXPORT  __Vectors
__Vectors 
              DCD  0x20001000 		;Stack Pointer Address	!!!
              DCD  Reset_Handler  	;reset vector
              ALIGN 
		
		AREA   CS2400_Fall2019, CODE, READONLY
    	ENTRY
   	      EXPORT Reset_Handler
Reset_Handler
;;~~~~~~~~STANDARD BEGINNING CODE (End)~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~CODE BELOW HERE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;-----------------BL = Branch Link	== Function call (Returns to same spot after Call Complete)  -------------------------------------------------------
;	MOV R0, #1	
;	MOV R2, #3	
;	BL proc1	;JUMP to proc1 Method & Return to Here
;	BL proc2	;JUMP to proc2 Method & Return to Here
;	MOV R4,R3
;	B stop
;proc1
;	ADD R3,R0,R2
;	MOV PC,R14
;proc2
;	SUB R3,R0,#1
;	MOV PC,R14
;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	MOV R0,#1	;a	
;	CMP R0,#1
;	BLEQ case1
;	CMP R0,#2
;	BLEQ case2
;	ADDNE R0,R0,#5	
;	B stop
;case1	
;	ADD R0,R0,#1
;	MOV PC, LR	;R13<-R14	
;	B stop
;case2
;	ADD R0,R0,#2
;	MOV PC, LR	;R13<-R14	
;	B stop

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~Using Link Register to move into Program Counter to JUMP Instructions~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	MOV R0,#1	;a	
;	CMP R0,#1
;	BLEQ case1
;	CMP R0,#2
;	BLEQ case2
;	ADDNE R0,R0,#5	
;	B stop
;case1	
;	ADD R0,R0,#1
;	MOV PC, LR	;;;R13<-R14	
;	B stop
;case2
;	ADD R0,R0,#2
;	MOV PC, LR	;;;R13<-R14	
;	B stop

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~check if the first letter of a given string is 'H'.~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;	LDR R0, = string1	;R0 = string1
;;	LDRB R2,[R0],#1		;R2 = string1[0] = 'H'
;;	LDR R3,=ch;			;R3 = ch Address
;;	LDRB R3,[R3]		;R3 = 'H'	ch[0] = 'H'
;;	TEQ R3,R2			; R3 == R2 ?

;;stop		B stop
;;string1	DCB "Hello world!",0
;;ch		DCB "H"

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 	MOV 	 	R2,#0x01 	 	; R2 = 01
; 	MOV 	 	R3,#0x02 	 	; R3 = 02 
; 	ADD 	 	R1,R2,R3 	 	; R1 = 03 
; 	MOV 	 	R3,#0xFFFFFFFF  ; R3 = 4294967295  	; 'N'egative/'Z'ero/'C'arry/O'V'erflow
; 	ADDS 	 	R1,R2,R3 	    ; R1 = 00  			N=0/Z=1/C=1/V=0
; 	SUBS 	 	R1,R2,R3 	    ; R1 = 2 	N=0/Z=0/C=0/V=0
;	MOV 		R4,#0xFFFFFFFF 	; R4 = 4294967295
;	ADD 		R1,R2,R4 		; R1 = 00  	No Flags Set	
;;;;How did that operation affect the flags in xPSR/CPSR?	
;	ADDS 		R1,R2,R4 		; R1 = 00  	N=0/Z=1/C=1/V=0
;	MOV 		R2, #0x00000002 ; R2 = 02	N=0/Z=1/C=1/V=0
;	ADDS 		R1,R2,R4 		; R1 = 01	N=0/Z=0/C=1/V=0					
;;;;Move 2 values in R2 and R3 in the below instructions to set the overflow flag to 1.
;	MOV 		R2, #0xFFFFFFFF 	; R2 = 4294967295
;	MOV 		R3, #0xFFFFFFFF		; R3 = 4294967295
;	ADDS 		R1,R2,R3 			; R1 = 01	N=0/Z=0/C=1/V=1			
;;;;Check and write the flags in the xPSR/CPSR? ( 3 points)
;;;;Move 2 values in R2 and R3 in the below instructions to set the zero flag to 1.
;	MOV R2, #0xFFFFFFFF 	; R2 = 4294967295
;	MOV R3, #0x00000001 	; R3 = 01
;	ADDS R1,R2,R3 			; R1 = 00	N=0/Z=1/C=1/V=0
;;;;Check and write the flags in the xPSR/CPSR? ( 3 points)
	
;;;;Move 2 values in R2 and R3 in the below instructions to set the negative flag to 1.
;	MVN R2, #49 	; R2 = -50
;	MOV R3, #0 		; R3 = 0
;	ADDS R1,R2,R3 	; R1 = -50	N=1/Z=0/C=0/V=0	
;;;;Check and write the flags in the xPSR/CPSR? ( 3 points)
;	
;
;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;--------------------------------Math Program
;; 	Problem #2.	Write an ARM assembly program to calculate the value of the following function: (5 points)
;;	FunSolve.s	
;;	Name: Christopher Welch
;;	Date: 02/20/20
;;		f(y) = 3(3)^2 – 2(3) + 10, when y = 3. 
;	MOV r0,#3		;r0 = 3 = y
;	MOV r1,#3		;r1 = 3
;	MUL r1,r1,r1	;r1 = 3*3
;	MUL r1,r1,r0	;r1 = 9*3
;	MOV r2,#2
;	MUL r2,r2,r0	;r2 = 2*3
;	SUB r0,r1,r2
;	ADD r0,#10		;<-SOLUTION	= 0d31 || 0x1F	
;stop B stop


;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;--------------------------------Factorial Nieve
;	LDR R4,=a
;	LDR R1,[R4]
;	MOV R3,#1
;loop1
;	SUB R2, R1, #1
;	CBZ R2, exit
;		MUL R3,R3,R1
;	SUB R1,R1,#1
;	B loop1
;exit
;stop B stop

;a DCD 3
;	END

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;------------------ Factorial Modified
;	MOV r3,#5
;	MOV r2,#1
;loop
;	CMP r3,#0
;	MULGT r2,r3,R2
;	SUBGT r3,r3,#1
;	BGT loop
;stop B stop
;	END

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;------------------ Factorial using Link Register (LR) to fill the Program Counter (PC)
;	MOV r0, #6	;Factorial Number	n
;	MOV r1, #1	;Decrementer		-1
;	MOV r4, #0	;Factorial Total
;	BL fact		
;	B stop 			
;	fact				;NOTES: 	STMIA R4!,(lr)	Then->	exitfun LDMDB R4!,(pc)	 !!!! ;0x20001000 = Stack Pointer Address	!!!
;	CBZ r0, stop	;if n = 0
;	SUB r2,r0,r1 	;Value n-1
;	MUL r3,r0,r2	; n=n*n-1	;r3 = Operation Total
;	ADD r4,r3,r4	; r4 = Factorial Total
;	SUB r0,r0,r1	;n = n-1	
;	CMP r0,#0		;CBNZ r0,fact	DOESN"T SUPPORT, 16 bits only
;	BGT fact		
;	MOV R13,R14			; PC <- LR

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;------------ Swap Contents of 2 Values
;	LDR r0,=2		; Load Arbritrary Data
;	LDR r1,=4		; Load Arbritrary Data
;	EOR r0,r0,r1	; r0 XOR r1
;	EOR r1,r0,r1	; r1 XOR r0
;	EOR r0,r0,r1	; r0 XOR r1

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~ Floating Point Operations = S0 -> S31		Doubles = D0 -> D15			~~~~~~~~~
;; LDR = Single Precision		VMOV, VLDR 		Processor MUST support Floating Point Numbers	'FPU'

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;-----------Area of Circle
;;VLDR.F32 s4,=3.14	Loading a Floating Point

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;-----------Using Suffixes
;	LDR r0,='!'		
;	TEQ R0, #!'		;Test Equal To
;	TEQNE R0, #?'	;Test NOT Equal To
;	ADDEQ r1,r1,#1	

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;------- Compare 2 Strings
;	LDR R4,=St1
;	LDR R0,[R4]
;	LDR R4,=St2
;	LDR R1,[R4]
;	TEQ RO,R1	;Z=0
;	
;	St1 DCB "one"
;	St2 DCB "test"
;	
;	LDR R4,=St1
;	LDR R0,[R4]
;	LDR R4,=St2
;	LDR R1,[R4]
;	TEQ R0,R1,	;Z=1
;	
;	St1 DCB "one"
;	St2 DCB "one"
;------ a DCD 4,2,3,1		is an array	 	w/ Memory Addresses of: (Base Address)1000, 1004, 1008, 1012
;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	LDR r0,=a
;LOOP
;	LDR R1,[R0,#0] ;#0 means the OFFSET = 0		goes by 1000 + 4n
;	ADD R2,R2,R1
;	ADD R0,R0,#4
;	ADD R3,R3,#1
;	CMP R3,#4
;	BLT LOOP
;a DCD 4,2,3,1	

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;-------Looping & Array
;	LDR r0,=a		; Base Address = 1000
;LOOP				; Loop Label
;	LDR R1,[R0,#0]	;	R1 = 6	  --Reads
;	ADD R2,R2,R1	;	R2 = 6	  --Sum
;	ADD R0,R0,#8	;	R0 = 1008 --Address Update	--Alternating Numbers
;	ADD R3,R3,#1	;	Increment Counter
;	CMP R3,#3		;	Is Counter 3?
;	BLT LOOP		;	6+2+1 = 9
;a DCD 6,4,2,3,1		;

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~Read an Array & check if a # is in the Array.
;	LDR r10,=#5		;Looking for #5
;	LDR r11,=#0		;Incrementer
;	LDR r0,=a		;Base Address Loaded
;	LDR r1,[r0,#0]	;1st Number	& Register to READ
;ArrayReader		
;	CMP r10, r1
;	BEQ Incrementer
;;~~~~~~~~~~~~~~~Modify to count # of occurences of the #.	
;Incrementer
;	ADD r11,r11,=#1		;Increment Counter
;	LDR r1,[r1,#4]		;Increment Array to see if Null	
;	CBZ r1, ArrayReader	;Check if r1 == 0
;	CBNZ r1, stop		;If Array == null	B stop		
;	
;a DCD 1,5,3,5			;1000=1	/	1004=3	/	1008=5

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
;;~~~~~~~~~~~~~~~Find Product of Array elements & Store product in Memory
;	LDR r0=a
;	LDR r1=[r0,#0]	;1
;	LDR r2=[r1,#4]	;3
;	LDR r3=[r2,#4]	;5
;	MUL r1,r1,r2
;	MUL r1,r1,r3	
;	
;a DCD 1,3,5			;1000=1	/	1004=3	/	1008=5

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
;;~~~~~~~~~~~~~~~Load/Store Memory Base Update/Unchanged
; Load/Store Types: Pre-Indexing (Base Updated||Base Unchanged) / Post-Indexing Base Updated  ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
; Adressing Mode: Mneumonic;  Address:  Final Value in R1
	;~~~ Pre-Indexed, Base Unchanged ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
;Effective Address: R1+d 	FinalValue: R1
;LDR R0,[R2,#4]	;#0 = Base Address+#4 = Index 2
	;~~~ Pre-Indexed, Base Updated ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;Effective Address: R1+d 	FinalValue: R1+d
;LDR R0,[R2,#4]!	;
	;~~~Post-Indexed, Base Updated ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;Effective Address: R1+d+d 	FinalValue: R2[2]
;LDR R0,[R2],#4	;#0 = Base Address +#4 = Index 2

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;			;; STMxx	&	LDMxx R0,{r1,r3}		xx == IB, IA, DB, DA  ->	IB+DA IA+DB
;;;;;;;;;;; LDM = Load to Memory		; STM = Store to Memory
;;;;;;;;;	(In|De)crementing (After|Before)		;Stack Pointer 1 = sp1
;;;;;;;;;;	STMIA	Store to Memory & Increment After
;	STMIA spl1,(r0-r5)		;Push Onto a Full Descending Stack		;
; 	LDMDA spl1,(r0-r5)		;Pop From a Full Descending Stack
;;;;;;;;;;	USE 'DB' to load from memory starting @ the last address.
; 	LDMDB SPI,{R0.R3}		;Load from Memory 
;	LDR R0,=arr
;	LDR	R5,=0x20000018		;FIND Stack Pointer Address in Debugger
;	BL checkEvenfun			;Check #'s->Store EVENS-Replace ODDS w/ '0'	;USE AND #1 to check if it's EVEN | ODD
;	BL sunFun				; Pop from stack Find the sum
;	B stop
;checkEvenfun
;	BL
;	
;loopValues
;sunFun
;array dcd 2,3,4,1

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	;HW: 3	=	NameLen.s & OddSum.s
;			;; STMxx	&	LDMxx R0,{r1,r3}

;;~~~~~~~~~~~~~~~~~~~~~	NameLen.s	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;NameLenMain	
;   LDR r0, =name		; R0 = name[...] = chris
;	LDRB r1,[r0],#1		; R1 = name[0] = 'c'	
;	MOV r3, #1			; R3 = Incrementer
;	MOV r4, #0			; R4 = Total Elements in Array
;	B loop
;loop					;Read through the 'name' array until the end	
;	CMP r1,r10			; R1 == 0 ?		; 0 == null
;	BEQ finishNameLen	; If R1 == 0, stop.	ELSE
;	ADD r4, r4, r3		; R4++	 ->	Elements++
;	LDRB r1,[r0],#1		; name[n++]
;	B loop				; loop()
;; R4 = 5 at the End.	 'chris'.length = 5.
;finishNameLen
;	MOV r0,#0
;	ADD r0,r0,r4		; R0 = Array Length
;  B OddSumMain			; END of NameLen.s	
;  
;name DCB "chris",0		; Char Array

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~~~~~~	OddSum.s	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;		;Write an ARM assembly program (OddSum.s) to read 12 array integer elements.
;		;Write two functions in the program, one to save only the odd numbers into memory.
;		;And the second one to find the sum of the odd numbers and store in R3. */
;OddSumMain	
;	LDR r0, =numArray	; R0 = numArray[12]
;	LDR r1,[r0,#0]!		; R1 = numArray[0]	;1st Element
;	MOV r3, #1			; R3 = Incrementer / AND'er
;	MOV r4, #0			; R4 = OddSum = 0;
;	B numReader
;numReader	
;	CMP r1,#12			; R1 > 12?	
;	BGT finishOddSum	; finishOddSum();	Else:		
;	AND r5, r1, r3		; R5 = R1 AND 1
;	CMP r5, #1			; If R5 == 1, 	R1 is ODD
;	BEQ saveNum			; saveNum()		Else:
;	LDR r1,[r0,#4]!		; numArray[n++]	
;	B numReader			; Else	
;	
;saveNum
;	;STR [R1,#4]	;STM savedNums			;Store R1 in savedNums[]	;Try some other time
;	B addOdds
;addOdds
;	ADD r4, r1, r4		;R4 -> Oddsums += numArray[n]
;	LDR r1,[r0,#4]!		; R1 = numArray[0]	;1st Element	
;	B numReader
;finishOddSum
;	MOV r3, #0
;	ADD r3, r3, r4		; R3 = OddSums
;	B stop
;	
;numArray dcd 1,2,3,4,5,6,7,8,9,10,11,12		; numArray[12] = 1-12
;;savedNums dcd 0,0,0,0,0,0,0,0,0,0,0,0,0		; savedNums[13]

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~ TO USE NESTED FUNCTION CALLS		Must Store Address Data
;	MOV R0,#3
;	MOV R1,#4
;	LDR	R5,=0X20000018
;	BL	Fun1
;	B	stop
;Fun1
;	MOV R2,#2
;	STMFD R5!,(LR)
;	BL Fun2
;	LDMFD R5!,(PC)
;Fun2
;	MOV R3,#3
;	MOV PC, LR	;R13<-R14	
;stop
;	END

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;ASR = Arithmetic Shift Right (Sign Bit Reseverd)
	;ROR = Rotate Right

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Copy Bits with Bit Masking & Stored to Memory~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;// Name, 900 number, Date, Time taken for doing the program, References.
;						;Name:  Christopher Welch		;Date: 	04/04/20
;						;Student #:900915317  			;Time: 	1 Hour	;References: Did it by Memory	   
;;;; // Use A	//Load R0 into R3	// #0d9915317 = #0x974BB5	 	
;	LDR R0, A
;	MOV R3, R0		;;Copy of A		
;	MOV R1, #0x3FF	;;AND for 0-9	
;	MOV R2, #0xFFF	;;AND for 0-11
;	
;	;;// Copy 1st 10 bits of the value stored in R3 into R5		
;	AND R5,R0,R1		
;	
;	;;// Copy 10 bits from 11 to 20 to R6		
;	LSR R0,#10
;	AND R6,R0,R1		
;	
;	;;// Copy 12 bits 21 t0 32 in R7		
;	LSR R0,#10
;	AND R7,R0,R2			
;	
;	;// Store the values in a stack in the order R6, R5, R7
;	STM SP, {R6,R5,R7}	
;A DCD 0X974BB5
;stop b stop 		


;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;;HW4	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~PARITY BIT
;;; and LSR by 1 and loop again, then LSL by 1 and ORRing the first bit to append the parity bit to the 
;;; original input to store it in R3.
;	MOV R1, #0x4E		;0100 1110	;EVEN PARITY	;TO 0 1001 1100
;	MOV R2, R1	;Copy to LSR	
;	MOV R3, R1
;	MOV R5, #8	;# of bits to read
;	MOV R6, #0	;Total Bits with '1'	
;	B LOOP
;LOOP
;	CMP R5, #0			;(i == 0? finisher() : continue)
;	BEQ finisher		
;	AND R7, R2, #1		;Bit in First position?
;	BL  checkBit	
;	LSR R2, #1
;	SUB R5, R5, #1		;i--
;	B LOOP	
;checkBit
;	CMP R7, #1
;	BEQ addBit
;	MOV PC,R14
;addBit
;	ADD R6, R6, #1	;Total Bits w/'1'
;	SUB R7, R7, #1
;	B   checkBit
;finisher
;	LSL R3, #1 
;	AND R7,R6,#1 
;	ORR	R3,R3,R7	


;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~~~~Flags~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;~~~~~~~~~~~~~STANDARD ENDING~~~~~~~~~~~~~~~~NO MORE CODE BEYOND THIS POINT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
stop B stop
			END