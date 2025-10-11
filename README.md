Assignment 2
Nasim Allu
Abdulah Dautovic

This is our explanation of the code for the following tasks on Assignment 2.

-------------------------------------------------------------------------------------------------------

### Task 1
In the first task we started by copying all the files from the “Temple” directory 
and made a simple change. We changed the file from "HelloWord.S" to "main.S".  
We also fixed a few lines in the code but not a lot.

### Task 2
We started by connecting pins "GP0", "GP1", and "GP2" to the long side (anode) of the LEDs.  
Then connected "GND" to the blue line on the breadboard.  
After that we put three resistors between the short side (cathode) of each LED and the blue line on the breadboard.

The program first sets up pins GP0, GP1, and GP2 and make them as outputs.  
In the loop LED1 turned on then wait for 200 milliseconds and after LED1 is turned off.  
The same steps are repeated for LED2 and LED3.

The functions "gpio_init", "link_gpio_set_dir", and "link_gpio_put" are used to control the pins.  
The program runs forever using a infinite loop.  

We copied "CMakeLists.txt", "pico_sdk_import.cmake", and "sdklink.c" without changing them. The only file we changed was "main.s".

### Task 3
We used the same files and connections.  
In the "main.s" file, we didnt change the main setup, but we fixed the loop.  

In this loop a counter control the LEDs in a binary pattern from 0 to 7.  
Each bit of the counter is for one LED, so it turns on or off depending on the number.   
After updating the LEDs, the program waits 1000 milliseconds.  

When the counter reache 7, the direction changes to count down back to 0, and when it reaches 0, it changes to count up again.  
This loop repeats indefinitely, creating a binary counting on the three LEDs.

### Task 4
We connected a "7-segment display" to the Raspberry Pi Pico.  
Segments from A to G were connected to pins "GP0" to "GP6", and the common cathode went to GND with a resistor.  


In the program, all pins GP0–GP6 were set as outputs using the functions "gpio_init" and "link_gpio_set_dir".  
Each pin controls one segment of the display.  

The program uses a table called "digits" that stores the bit for the numbers 0–9.  
Each pattern shows which segments should be turned on to display that number.  
For example "0x3F" shows number 0 and "0x06" shows number 1.

The program starts by setting all GPIO pins.  
Then it begins to count from 0 to 9, showing each number on the 7-segment display.  
When it reaches 9, it counts back down to 0, and this repeats forever.  
After each number the program waits 1 second using the "sleep_ms" function before showing the next number.



We copied the files "CMakeLists.txt", "pico_sdk_import.cmake", and "link_gpio.c" without changing them.  
The only file we wrote and changed was "main.S".
