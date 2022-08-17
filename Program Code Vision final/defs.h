/* definitions / defines file */
#define DEFS_H

#define SW_VERSION		13   /* i.e. major.minor software version nbr. */

#ifndef NULL
#define NULL  0
#endif
        
// logix ...
#define TRUE	1
#define FALSE	0 
#define DUMMY	0

#define wdogtrig()			#asm("wdr") // call often if Watchdog timer enabled

#define CR				0x0D
#define LF				0x0A  

#define LED1 PORTD.6        // PORTx is used for output
#define LED2 PORTD.4        // PORTx is used for output
#define LED3 PORTD.3        // PORTx is used for output
#define LED4 PORTD.2        // PORTx is used for output
#define afisaj_1 PORTC.5
#define afisaj_2 PORTC.4
#define afisaj_3 PORTC.3
#define afisaj_4 PORTC.2
#define afisaj_5 PORTC.1
#define afisaj_6 PORTC.0

#define buzzer PORTB.5

#define SW1 PIND.5          // PINx is used for input
#define SW3 PINB.0          // PINx is used for input
#define SW4 PINB.1          // PINx is used for input
#define SW5 PINB.2          // PINx is used for input
#define SW6 PINB.3          // PINx is used for input
#define SW7 PINC.6          // PINx is used for input
#define SW8 PINC.7          // PINx is used for input

// #define TESTP PORTD.4       // test bit durations
#include "funct.h"

