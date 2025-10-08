@
@ Assembler program to flash three LEDs connected to the
@ Raspberry Pi Pico GPIO port using the Pico SDK.
@

	.EQU	LED_PIN1, 0
	.EQU	LED_PIN2, 1
	.EQU	LED_PIN3, 2
	.EQU	GPIO_OUT, 1
	.EQU	sleep_time, 1000

.thumb_func	@ Necessary because sdk uses BLX
.global main    @ Provide program starting address

main:
	MOV	R0, #LED_PIN1	
	BL	gpio_init	
	MOV	R0, #LED_PIN1	
	MOV	R1, #GPIO_OUT	
	BL	link_gpio_set_dir
	
	MOV	R0, #LED_PIN2
	BL	gpio_init
	MOV	R0, #LED_PIN2
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	
	MOV	R0, #LED_PIN3	
	BL	gpio_init	
	MOV	R0, #LED_PIN3	
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	
	MOV R7, #0 	@counter
	MOV R6, #0 	@direction
	
	
loop:
	
	MOV R3, #7 
	AND R7, R7, R3		@limit R7 to 3 bit so if its bigger then masks down
	
	MOV R2, R7		@r7 into r2
	MOV R3, #1		@1 into r3
	AND R2, R2, R3		@ keep only las num of R7 (0 or 1)
	MOV R1, R2		@result moved to r1
	MOV R0, #LED_PIN1
	BL link_gpio_put		@ turn on
	
	MOV R2, R7
	LSR R2, R2, #1		@ it kepp only second num of R7
	MOV R3, #1
	AND R2, R2, R3
	MOV R1, R2
	MOV R0, #LED_PIN2
	BL link_gpio_put
	
	MOV R2, R7
	LSR R2, R2, #2		@ it keep only third num of r7
	MOV R3, #1
	AND R2, R2, R3
	MOV R1, R2
	MOV R0, #LED_PIN3
	BL link_gpio_put
	
	LDR R0, =sleep_time
	BL sleep_ms 
	
	CMP R6, #0
	BNE down		@ if R6 isnt 0 go to "down"

@ if all leds on, change direction, if its not add 1 to r7, then back to loop
up:
	CMP R7, #7
	BNE up_notmax
	MOV R6, #1
	SUB R7, R7, #1
	BNE down
up_notmax:
	ADD R7, R7, #1
	B loop

@same but this time if all led is of	
down:
	CMP R7, #0
	BNE down_notmin
	MOV R6, #0
	ADD R7, R7, #1
	B loop
down_notmin:
	SUB R7, R7, #1
	B loop
	

