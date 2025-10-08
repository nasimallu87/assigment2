	.syntax unified
	.cpu cortex-m0plus
	.thumb
	.global main
	.thumb_func

@functions
	.extern gpio_init
	.extern sleep_ms
	.extern link_gpio_set_dir
	.extern link_gpio_put
	.equ GPIO_OUT, 1        @outbut = 1        
	.text
    
main:
   
    MOVS    R4, #0      @R4 = 0 (start with pin0)
1:  MOVS    R0, R4      @R0 = pin num            
    BL      gpio_init   @Call the function
    MOVS    R0, R4                  
    MOVS    R1, #GPIO_OUT
    BL      link_gpio_set_dir       @Ser pin as outbut
    ADDS    R4, R4, #1      @R4 = R4 + 1
    CMP     R4, #7          @compare R4 with 7
    BCC     1b      @ if R4 isnt 7, go back to 1


    MOVS    R6, #0      @start conting from 0
    MOVS    R5, #0      @start by conting up(0 for up and 1 for down)

loop_main:
    
    LDR     R0, =digits     @load address of digits table (the list of 0-9 bit patterns)
    ADDS    R0, R0, R6      @choose which num (index) to show
    LDRB    R4, [R0]        @ get wich LEDs to turn on for this num

   
    MOVS    R7, #0           
2:  MOVS    R1, R4            
    MOVS    R3, #1            
    ANDS    R1, R3            
    MOVS    R0, R7            
    BL      link_gpio_put     
    LSRS    R4, R4, #1
           
    ADDS    R7, R7, #1      @ next pin
    CMP     R7, #7          @ compaere with 7
    BCC     2b              @ if < 7, loop again

   
    LDR     R0, =1000       @ R0 = 1000 (time)
    BL      sleep_ms        @ wait 1000 ms

    
    CMP     R5, #0      
    BNE     dir_down        @ R5 = 0 => no jump     

    
    CMP     R6, #9   
    BNE     inc_ok
    MOVS    R5, #1      @ change diraction to down             
    SUBS    R6, R6, #1        
    B       loop_main
inc_ok:
    ADDS    R6, R6, #1      @ digit = digit + 1
    B       loop_main

@same as there uo but this time to see if its 0 so it count up

dir_down:
    
    CMP     R6, #0
    BNE     dec_ok
    MOVS    R5, #0            
    ADDS    R6, R6, #1        
    B       loop_main
dec_ok:
    SUBS    R6, R6, #1      digit = digit - 1
    B       loop_main


	.data
	.align 1
digits:
    .byte 0x3F    @ 0
    .byte 0x06    @ 1
    .byte 0x5B    @ 2
    .byte 0x4F    @ 3
    .byte 0x66    @ 4
    .byte 0x6D    @ 5
    .byte 0x7D    @ 6
    .byte 0x07    @ 7
    .byte 0x7F    @ 8
    .byte 0x6F    @ 9
