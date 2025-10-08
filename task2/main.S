@
@ Assembler program to flash three LEDs connected to the
@ Raspberry Pi Pico GPIO port using the Pico SDK.
@

	.EQU	LED_PIN1, 0		@led1 = gpio 0
	.EQU	LED_PIN2, 1		@led2 = gpio 1
	.EQU	LED_PIN3, 2		@led3 = gpio 2
	.EQU	GPIO_OUT, 1		@ outbut = 1
	.EQU	sleep_time, 200		@ time 200 millisecond

.thumb_func		@ Necessary because sdk uses BLX
.global main    @ Provide program starting address

main:
	MOV	R0, #LED_PIN1		@led1 into R0
	BL	gpio_init			@call the function for led1
	MOV	R0, #LED_PIN1		@led1 into R0 again
	MOV	R1, #GPIO_OUT		@output into R1
	BL	link_gpio_set_dir	@set led1 as output
	
@same as led1 

	MOV	R0, #LED_PIN2
	BL	gpio_init
	MOV	R0, #LED_PIN2
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	
@same as led1 and led2

	MOV	R0, #LED_PIN3
	BL	gpio_init
	MOV	R0, #LED_PIN3
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	
loop:   
	MOV	R0, #LED_PIN1		@led1 into R0
	MOV	R1, #1				@put 1 to turn on led1
	BL	link_gpio_put		@turn on led1
	LDR	R0, =sleep_time		@load the time = 200 millisecond
	BL	sleep_ms			@wait 200 millisecond
	MOV	R0, #LED_PIN1		@led1 into R0
	MOV	R1, #0				@ put 0 to turn off
	BL	link_gpio_put		@ turn off
	
@same as led1

	MOV	R0, #LED_PIN2
	MOV	R1, #1
	BL	link_gpio_put
	LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN2
	MOV	R1, #0
	BL	link_gpio_put

@same as led1 and 2

	MOV	R0, #LED_PIN3
	MOV	R1, #1
	BL	link_gpio_put
	LDR	R0, =sleep_time
	BL	sleep_ms
	MOV	R0, #LED_PIN3
	MOV	R1, #0
	BL	link_gpio_put
	
	B       loop		@infinite loop
