
;CodeVisionAVR C Compiler V3.46a 
;(C) Copyright 1998-2021 Pavel Haiduc, HP InfoTech S.R.L.
;http://www.hpinfotech.ro

;Build configuration    : Release
;Chip type              : ATmega164A
;Program type           : Application
;Clock frequency        : 20.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': No
;'char' is unsigned     : No
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Mode 1
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega164A
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E
	.EQU GPIOR1=0x2A
	.EQU GPIOR2=0x2B

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x04FF
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETW1P
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETD1P_INC
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X+
	.ENDM

	.MACRO __GETD1P_DEC
	LD   R23,-X
	LD   R22,-X
	LD   R31,-X
	LD   R30,-X
	.ENDM

	.MACRO __PUTDP1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTDP1_DEC
	ST   -X,R23
	ST   -X,R22
	ST   -X,R31
	ST   -X,R30
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __CPD10
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	.ENDM

	.MACRO __CPD20
	SBIW R26,0
	SBCI R24,0
	SBCI R25,0
	.ENDM

	.MACRO __ADDD12
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	ADC  R23,R25
	.ENDM

	.MACRO __ADDD21
	ADD  R26,R30
	ADC  R27,R31
	ADC  R24,R22
	ADC  R25,R23
	.ENDM

	.MACRO __SUBD12
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	.ENDM

	.MACRO __SUBD21
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R25,R23
	.ENDM

	.MACRO __ANDD12
	AND  R30,R26
	AND  R31,R27
	AND  R22,R24
	AND  R23,R25
	.ENDM

	.MACRO __ORD12
	OR   R30,R26
	OR   R31,R27
	OR   R22,R24
	OR   R23,R25
	.ENDM

	.MACRO __XORD12
	EOR  R30,R26
	EOR  R31,R27
	EOR  R22,R24
	EOR  R23,R25
	.ENDM

	.MACRO __XORD21
	EOR  R26,R30
	EOR  R27,R31
	EOR  R24,R22
	EOR  R25,R23
	.ENDM

	.MACRO __COMD1
	COM  R30
	COM  R31
	COM  R22
	COM  R23
	.ENDM

	.MACRO __MULD2_2
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	.ENDM

	.MACRO __LSRD1
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	.ENDM

	.MACRO __LSLD1
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	.ENDM

	.MACRO __ASRB4
	ASR  R30
	ASR  R30
	ASR  R30
	ASR  R30
	.ENDM

	.MACRO __ASRW8
	MOV  R30,R31
	CLR  R31
	SBRC R30,7
	SER  R31
	.ENDM

	.MACRO __LSRD16
	MOV  R30,R22
	MOV  R31,R23
	LDI  R22,0
	LDI  R23,0
	.ENDM

	.MACRO __LSLD16
	MOV  R22,R30
	MOV  R23,R31
	LDI  R30,0
	LDI  R31,0
	.ENDM

	.MACRO __CWD1
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	.ENDM

	.MACRO __CWD2
	MOV  R24,R27
	ADD  R24,R24
	SBC  R24,R24
	MOV  R25,R24
	.ENDM

	.MACRO __SETMSD1
	SER  R31
	SER  R22
	SER  R23
	.ENDM

	.MACRO __ADDW1R15
	CLR  R0
	ADD  R30,R15
	ADC  R31,R0
	.ENDM

	.MACRO __ADDW2R15
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	.ENDM

	.MACRO __EQB12
	CP   R30,R26
	LDI  R30,1
	BREQ PC+2
	CLR  R30
	.ENDM

	.MACRO __NEB12
	CP   R30,R26
	LDI  R30,1
	BRNE PC+2
	CLR  R30
	.ENDM

	.MACRO __LEB12
	CP   R30,R26
	LDI  R30,1
	BRGE PC+2
	CLR  R30
	.ENDM

	.MACRO __GEB12
	CP   R26,R30
	LDI  R30,1
	BRGE PC+2
	CLR  R30
	.ENDM

	.MACRO __LTB12
	CP   R26,R30
	LDI  R30,1
	BRLT PC+2
	CLR  R30
	.ENDM

	.MACRO __GTB12
	CP   R30,R26
	LDI  R30,1
	BRLT PC+2
	CLR  R30
	.ENDM

	.MACRO __LEB12U
	CP   R30,R26
	LDI  R30,1
	BRSH PC+2
	CLR  R30
	.ENDM

	.MACRO __GEB12U
	CP   R26,R30
	LDI  R30,1
	BRSH PC+2
	CLR  R30
	.ENDM

	.MACRO __LTB12U
	CP   R26,R30
	LDI  R30,1
	BRLO PC+2
	CLR  R30
	.ENDM

	.MACRO __GTB12U
	CP   R30,R26
	LDI  R30,1
	BRLO PC+2
	CLR  R30
	.ENDM

	.MACRO __CPW01
	CLR  R0
	CP   R0,R30
	CPC  R0,R31
	.ENDM

	.MACRO __CPW02
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	.ENDM

	.MACRO __CPD12
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	CPC  R23,R25
	.ENDM

	.MACRO __CPD21
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
	.ENDM

	.MACRO __BSTB1
	CLT
	TST  R30
	BREQ PC+2
	SET
	.ENDM

	.MACRO __LNEGB1
	TST  R30
	LDI  R30,1
	BREQ PC+2
	CLR  R30
	.ENDM

	.MACRO __LNEGW1
	OR   R30,R31
	LDI  R30,1
	BREQ PC+2
	LDI  R30,0
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETW1Z
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETD1Z
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETW2X
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETD2X
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _rx_wr_index0=R3
	.DEF _rx_rd_index0=R2
	.DEF _rx_counter0=R5
	.DEF _tx_wr_index0=R4
	.DEF _tx_rd_index0=R7
	.DEF _tx_counter0=R6
	.DEF _minut_alarma=R8
	.DEF _minut_alarma_msb=R9
	.DEF _ora_alarma=R10
	.DEF _ora_alarma_msb=R11
	.DEF _ok=R12
	.DEF _ok_msb=R13

;GPIOR0-GPIOR2 INITIALIZATION VALUES
	.EQU __GPIOR0_INIT=0x00
	.EQU __GPIOR1_INIT=0x00
	.EQU __GPIOR2_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer1_compa_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart0_rx_isr
	JMP  0x00
	JMP  _usart0_tx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0

_0x16:
	.DB  0x3F,0x0,0x6,0x0,0x5B,0x0,0x4F,0x0
	.DB  0x66,0x0,0x6D,0x0,0x7D,0x0,0x7,0x0
	.DB  0x7F,0x0,0x6F,0x0,0x77
_0x17:
	.DB  0x15,0x0,0x0,0x1
_0x2040060:
	.DB  0x1
_0x2040000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  0x0C
	.DW  __REG_VARS*2

	.DW  0x15
	.DW  _cifra
	.DW  _0x16*2

	.DW  0x04
	.DW  _currentTime_G000
	.DW  _0x17*2

	.DW  0x01
	.DW  __seed_G102
	.DW  _0x2040060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0-GPIOR2 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30
	;__GPIOR1_INIT = __GPIOR0_INIT
	OUT  GPIOR1,R30
	;__GPIOR2_INIT = __GPIOR0_INIT
	OUT  GPIOR2,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0x01

	.DSEG
	.ORG 0x200

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
;interrupt [21] void usart0_rx_isr(void)
; 0000 0049 {

	.CSEG
_usart0_rx_isr:
; .FSTART _usart0_rx_isr
	RCALL SUBOPT_0x0
; 0000 004A char status, data;
; 0000 004B status = UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	LDS  R17,192
; 0000 004C data = UDR0;
	LDS  R16,198
; 0000 004D if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN)) == 0) {
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x3
; 0000 004E rx_buffer0[rx_wr_index0++] = data;
	MOV  R30,R3
	INC  R3
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer0)
	SBCI R31,HIGH(-_rx_buffer0)
	ST   Z,R16
; 0000 004F #if RX_BUFFER_SIZE0 == 256
; 0000 0050 // special case for receiver buffer size=256
; 0000 0051 if (++rx_counter0 == 0) rx_buffer_overflow0 = 1;
; 0000 0052 #else
; 0000 0053 if (rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0 = 0;
	LDI  R30,LOW(8)
	CP   R30,R3
	BRNE _0x4
	CLR  R3
; 0000 0054 if (++rx_counter0 == RX_BUFFER_SIZE0)
_0x4:
	INC  R5
	LDI  R30,LOW(8)
	CP   R30,R5
	BRNE _0x5
; 0000 0055 {
; 0000 0056 rx_counter0=0;
	CLR  R5
; 0000 0057 rx_buffer_overflow0=1;
	SBI  0x1E,0
; 0000 0058 }
; 0000 0059 #endif
; 0000 005A }
_0x5:
; 0000 005B }
_0x3:
	LD   R16,Y+
	LD   R17,Y+
	RJMP _0x20A
; .FEND
;char getchar(void)
; 0000 0062 {
; 0000 0063 char data;
; 0000 0064 while (rx_counter0 == 0);
;	data -> R17
; 0000 0065 data=rx_buffer0[rx_rd_index0++];
; 0000 0066 #if RX_BUFFER_SIZE0 != 256
; 0000 0067 if (rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0 = 0;
; 0000 0068 #endif
; 0000 0069 #asm("cli")
; 0000 006A --rx_counter0;
; 0000 006B #asm("sei")
; 0000 006C return data;
; 0000 006D }
;interrupt [23] void usart0_tx_isr(void)
; 0000 007D {
_usart0_tx_isr:
; .FSTART _usart0_tx_isr
	RCALL SUBOPT_0x0
; 0000 007E if (tx_counter0)
	TST  R6
	BREQ _0xC
; 0000 007F {
; 0000 0080 --tx_counter0;
	DEC  R6
; 0000 0081 UDR0=tx_buffer0[tx_rd_index0++];
	MOV  R30,R7
	INC  R7
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer0)
	SBCI R31,HIGH(-_tx_buffer0)
	LD   R30,Z
	STS  198,R30
; 0000 0082 #if TX_BUFFER_SIZE0 != 256
; 0000 0083 if (tx_rd_index0 == TX_BUFFER_SIZE0) tx_rd_index0=0;
	LDI  R30,LOW(8)
	CP   R30,R7
	BRNE _0xD
	CLR  R7
; 0000 0084 #endif
; 0000 0085 }
_0xD:
; 0000 0086 }
_0xC:
_0x20A:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
; .FEND
;void putchar(char c)
; 0000 008D {
; 0000 008E while (tx_counter0 == TX_BUFFER_SIZE0);
;	c -> Y+0
; 0000 008F #asm("cli")
; 0000 0090 if (tx_counter0 || ((UCSR0A & DATA_REGISTER_EMPTY)==0))
; 0000 0091 {
; 0000 0092 tx_buffer0[tx_wr_index0++]=c;
; 0000 0093 #if TX_BUFFER_SIZE0 != 256
; 0000 0094 if (tx_wr_index0 == TX_BUFFER_SIZE0) tx_wr_index0=0;
; 0000 0095 #endif
; 0000 0096 ++tx_counter0;
; 0000 0097 }
; 0000 0098 else
; 0000 0099 UDR0=c;
; 0000 009A #asm("sei")
; 0000 009B }

	.DSEG
;interrupt [14] void timer1_compa_isr(void)
; 0000 00C9 {

	.CSEG
_timer1_compa_isr:
; .FSTART _timer1_compa_isr
	ST   -Y,R26
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
; 0000 00CA //LED1 = ~LED1; // invert LED
; 0000 00CB 
; 0000 00CC currentTime.secunda ++;
	__GETB1MN _currentTime_G000,5
	SUBI R30,-LOW(1)
	__PUTB1MN _currentTime_G000,5
	SUBI R30,LOW(1)
; 0000 00CD cronometruTime.c_secunda ++;
	__GETB1MN _cronometruTime_G000,2
	SUBI R30,-LOW(1)
	__PUTB1MN _cronometruTime_G000,2
	SUBI R30,LOW(1)
; 0000 00CE 
; 0000 00CF if (currentTime.secunda >= 60) {
	__GETB2MN _currentTime_G000,5
	CPI  R26,LOW(0x3C)
	BRLO _0x18
; 0000 00D0 currentTime.secunda = 0;
	LDI  R30,LOW(0)
	__PUTB1MN _currentTime_G000,5
; 0000 00D1 currentTime.minut ++;
	RCALL SUBOPT_0x1
; 0000 00D2 }
; 0000 00D3 if (currentTime.minut >= 60) {
_0x18:
	__GETB2MN _currentTime_G000,4
	CPI  R26,LOW(0x3C)
	BRLO _0x19
; 0000 00D4 currentTime.minut = 0;
	LDI  R30,LOW(0)
	__PUTB1MN _currentTime_G000,4
; 0000 00D5 currentTime.ora ++;
	RCALL SUBOPT_0x2
; 0000 00D6 }
; 0000 00D7 if (currentTime.ora >= 24) {
_0x19:
	__GETB2MN _currentTime_G000,3
	CPI  R26,LOW(0x18)
	BRLO _0x1A
; 0000 00D8 currentTime.ora = 0;
	LDI  R30,LOW(0)
	__PUTB1MN _currentTime_G000,3
; 0000 00D9 currentTime.zi ++;
	RCALL SUBOPT_0x3
; 0000 00DA }
; 0000 00DB 
; 0000 00DC // luni cu 31 de zile
; 0000 00DD if (currentTime.luna == 1 || currentTime.luna == 3 ||currentTime.luna == 5 ||currentTime.luna == 7 ||currentTime.luna == 8 || currentTime.luna == 10 || currentTime.luna == 12) {
_0x1A:
	__GETB2MN _currentTime_G000,1
	CPI  R26,LOW(0x1)
	BREQ _0x1C
	CPI  R26,LOW(0x3)
	BREQ _0x1C
	CPI  R26,LOW(0x5)
	BREQ _0x1C
	CPI  R26,LOW(0x7)
	BREQ _0x1C
	CPI  R26,LOW(0x8)
	BREQ _0x1C
	CPI  R26,LOW(0xA)
	BREQ _0x1C
	CPI  R26,LOW(0xC)
	BRNE _0x1B
_0x1C:
; 0000 00DE if (currentTime.zi > 31) {
	__GETB2MN _currentTime_G000,2
	CPI  R26,LOW(0x20)
	BRLO _0x1E
; 0000 00DF currentTime.zi = 1;
	RCALL SUBOPT_0x4
; 0000 00E0 currentTime.luna ++;
; 0000 00E1 }
; 0000 00E2 }
_0x1E:
; 0000 00E3 
; 0000 00E4 // luni cu 30 de zile
; 0000 00E5 if (currentTime.luna == 4 || currentTime.luna == 6 ||currentTime.luna == 9 ||currentTime.luna == 11) {
_0x1B:
	__GETB2MN _currentTime_G000,1
	CPI  R26,LOW(0x4)
	BREQ _0x20
	CPI  R26,LOW(0x6)
	BREQ _0x20
	CPI  R26,LOW(0x9)
	BREQ _0x20
	CPI  R26,LOW(0xB)
	BRNE _0x1F
_0x20:
; 0000 00E6 if (currentTime.zi > 30) {
	__GETB2MN _currentTime_G000,2
	CPI  R26,LOW(0x1F)
	BRLO _0x22
; 0000 00E7 currentTime.zi = 1;
	RCALL SUBOPT_0x4
; 0000 00E8 currentTime.luna ++;
; 0000 00E9 }
; 0000 00EA }
_0x22:
; 0000 00EB 
; 0000 00EC // februarie
; 0000 00ED if (currentTime.luna == 2) {
_0x1F:
	__GETB2MN _currentTime_G000,1
	CPI  R26,LOW(0x2)
	BRNE _0x23
; 0000 00EE if (currentTime.an % 4 == 0) { // an bisect
	LDS  R30,_currentTime_G000
	ANDI R30,LOW(0x3)
	BRNE _0x24
; 0000 00EF if (currentTime.zi > 29) {
	__GETB2MN _currentTime_G000,2
	CPI  R26,LOW(0x1E)
	BRLO _0x25
; 0000 00F0 currentTime.zi = 1;
	RCALL SUBOPT_0x4
; 0000 00F1 currentTime.luna ++;
; 0000 00F2 }
; 0000 00F3 } else if (currentTime.zi > 28) {
_0x25:
	RJMP _0x26
_0x24:
	__GETB2MN _currentTime_G000,2
	CPI  R26,LOW(0x1D)
	BRLO _0x27
; 0000 00F4 currentTime.zi = 1;
	RCALL SUBOPT_0x4
; 0000 00F5 currentTime.luna ++;
; 0000 00F6 }
; 0000 00F7 }
_0x27:
_0x26:
; 0000 00F8 
; 0000 00F9 if (currentTime.luna > 12) {
_0x23:
	__GETB2MN _currentTime_G000,1
	CPI  R26,LOW(0xD)
	BRLO _0x28
; 0000 00FA currentTime.luna = 1;
	LDI  R30,LOW(1)
	__PUTB1MN _currentTime_G000,1
; 0000 00FB currentTime.an ++;
	LDS  R30,_currentTime_G000
	SUBI R30,-LOW(1)
	STS  _currentTime_G000,R30
; 0000 00FC }
; 0000 00FD 
; 0000 00FE 
; 0000 00FF //Cronometru
; 0000 0100 if (cronometruTime.c_secunda >= 60) {
_0x28:
	__GETB2MN _cronometruTime_G000,2
	CPI  R26,LOW(0x3C)
	BRLO _0x29
; 0000 0101 cronometruTime.c_secunda = 0;
	LDI  R30,LOW(0)
	__PUTB1MN _cronometruTime_G000,2
; 0000 0102 cronometruTime.c_minut ++;
	__GETB1MN _cronometruTime_G000,1
	SUBI R30,-LOW(1)
	__PUTB1MN _cronometruTime_G000,1
	SUBI R30,LOW(1)
; 0000 0103 }
; 0000 0104 if (cronometruTime.c_minut >= 60) {
_0x29:
	__GETB2MN _cronometruTime_G000,1
	CPI  R26,LOW(0x3C)
	BRLO _0x2A
; 0000 0105 cronometruTime.c_minut = 0;
	LDI  R30,LOW(0)
	__PUTB1MN _cronometruTime_G000,1
; 0000 0106 cronometruTime.c_ora ++;
	LDS  R30,_cronometruTime_G000
	SUBI R30,-LOW(1)
	STS  _cronometruTime_G000,R30
; 0000 0107 }
; 0000 0108 if (cronometruTime.c_ora >= 24) {
_0x2A:
	LDS  R26,_cronometruTime_G000
	CPI  R26,LOW(0x18)
	BRLO _0x2B
; 0000 0109 cronometruTime.c_ora = 0;
	LDI  R30,LOW(0)
	STS  _cronometruTime_G000,R30
; 0000 010A }
; 0000 010B 
; 0000 010C }
_0x2B:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R30,Y+
	LD   R26,Y+
	RETI
; .FEND
;void afisare(uint8_t param1, uint8_t param2, uint8_t param3)
; 0000 0110 {
_afisare:
; .FSTART _afisare
; 0000 0111 unsigned int DD0, DD1, DD2, DD3, DD4, DD5;
; 0000 0112 int i;
; 0000 0113 DD0 = param1 / 10;      // led 1
	ST   -Y,R26
	SBIW R28,8
	RCALL __SAVELOCR6
;	param1 -> Y+16
;	param2 -> Y+15
;	param3 -> Y+14
;	DD0 -> R16,R17
;	DD1 -> R18,R19
;	DD2 -> R20,R21
;	DD3 -> Y+12
;	DD4 -> Y+10
;	DD5 -> Y+8
;	i -> Y+6
	LDD  R26,Y+16
	LDI  R30,LOW(10)
	RCALL __DIVB21U
	MOV  R16,R30
	CLR  R17
; 0000 0114 DD0 = cifra[DD0];
	MOVW R30,R16
	RCALL SUBOPT_0x5
	LD   R16,X+
	LD   R17,X
; 0000 0115 
; 0000 0116 DD1 = param1 % 10;      // led 2
	LDD  R26,Y+16
	LDI  R30,LOW(10)
	RCALL __MODB21U
	RCALL SUBOPT_0x6
; 0000 0117 DD1 = cifra[DD1];
	LD   R18,X+
	LD   R19,X
; 0000 0118 
; 0000 0119 DD2 = param2 / 10;      // led 3
	LDD  R26,Y+15
	LDI  R30,LOW(10)
	RCALL __DIVB21U
	RCALL SUBOPT_0x7
; 0000 011A DD2 = cifra[DD2];
	LD   R20,X+
	LD   R21,X
; 0000 011B 
; 0000 011C DD3 = param2 % 10;      // led 4
	LDD  R26,Y+15
	LDI  R30,LOW(10)
	RCALL __MODB21U
	LDI  R31,0
	STD  Y+12,R30
	STD  Y+12+1,R31
; 0000 011D DD3 = cifra[DD3];
	RCALL SUBOPT_0x5
	LD   R30,X+
	LD   R31,X+
	STD  Y+12,R30
	STD  Y+12+1,R31
; 0000 011E 
; 0000 011F DD4 = param3 / 10;      // led 5
	LDD  R26,Y+14
	LDI  R30,LOW(10)
	RCALL __DIVB21U
	LDI  R31,0
	STD  Y+10,R30
	STD  Y+10+1,R31
; 0000 0120 DD4 = cifra[DD4];
	RCALL SUBOPT_0x5
	LD   R30,X+
	LD   R31,X+
	STD  Y+10,R30
	STD  Y+10+1,R31
; 0000 0121 
; 0000 0122 DD5 = param3 % 10;      // led 6
	LDD  R26,Y+14
	LDI  R30,LOW(10)
	RCALL __MODB21U
	LDI  R31,0
	STD  Y+8,R30
	STD  Y+8+1,R31
; 0000 0123 DD5 = cifra[DD5];
	RCALL SUBOPT_0x5
	LD   R30,X+
	LD   R31,X+
	STD  Y+8,R30
	STD  Y+8+1,R31
; 0000 0124 
; 0000 0125 //multiplexare
; 0000 0126 for (i = 0; i<=10; i++) {
	LDI  R30,LOW(0)
	STD  Y+6,R30
	STD  Y+6+1,R30
_0x2D:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SBIW R26,11
	BRGE _0x2E
; 0000 0127 PORTA = DD0;
	OUT  0x2,R16
; 0000 0128 afisaj_1 = 1;      // Selectie afisaj 1
	RCALL SUBOPT_0x8
; 0000 0129 afisaj_2 = 0;
; 0000 012A afisaj_3 = 0;
; 0000 012B afisaj_4 = 0;
; 0000 012C afisaj_5 = 0;
; 0000 012D afisaj_6 = 0;
; 0000 012E delay_ms(1);
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
; 0000 012F 
; 0000 0130 PORTA = DD1;
	OUT  0x2,R18
; 0000 0131 afisaj_1 = 0;      // Selectie afisaj 2
	RCALL SUBOPT_0x9
; 0000 0132 afisaj_2 = 1;
; 0000 0133 afisaj_3 = 0;
; 0000 0134 afisaj_4 = 0;
; 0000 0135 afisaj_5 = 0;
; 0000 0136 afisaj_6 = 0;
; 0000 0137 delay_ms(1);
; 0000 0138 
; 0000 0139 PORTA = DD2;
	OUT  0x2,R20
; 0000 013A afisaj_1 = 0;      // Selectie afisaj 3
	RCALL SUBOPT_0xA
; 0000 013B afisaj_2 = 0;
; 0000 013C afisaj_3 = 1;
; 0000 013D afisaj_4 = 0;
; 0000 013E afisaj_5 = 0;
; 0000 013F afisaj_6 = 0;
; 0000 0140 delay_ms(1);
; 0000 0141 
; 0000 0142 PORTA = DD3;
	LDD  R30,Y+12
	RCALL SUBOPT_0xB
; 0000 0143 afisaj_1 = 0;      // Selectie afisaj 4
; 0000 0144 afisaj_2 = 0;
; 0000 0145 afisaj_3 = 0;
; 0000 0146 afisaj_4 = 1;
	RCALL SUBOPT_0xC
; 0000 0147 afisaj_5 = 0;
; 0000 0148 afisaj_6 = 0;
; 0000 0149 delay_ms(1);
; 0000 014A 
; 0000 014B PORTA = DD4;
	LDD  R30,Y+10
	RCALL SUBOPT_0xB
; 0000 014C afisaj_1 = 0;      // Selectie afisaj 5
; 0000 014D afisaj_2 = 0;
; 0000 014E afisaj_3 = 0;
; 0000 014F afisaj_4 = 0;
	RCALL SUBOPT_0xD
; 0000 0150 afisaj_5 = 1;
; 0000 0151 afisaj_6 = 0;
; 0000 0152 delay_ms(1);
; 0000 0153 
; 0000 0154 PORTA = DD5;
	LDD  R30,Y+8
	RCALL SUBOPT_0xB
; 0000 0155 afisaj_1 = 0;      // Selectie afisaj 6
; 0000 0156 afisaj_2 = 0;
; 0000 0157 afisaj_3 = 0;
; 0000 0158 afisaj_4 = 0;
	RCALL SUBOPT_0xE
; 0000 0159 afisaj_5 = 0;
; 0000 015A afisaj_6 = 1;
; 0000 015B delay_ms(1);
; 0000 015C }
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2D
_0x2E:
; 0000 015D }
	RCALL __LOADLOCR6
	ADIW R28,17
	RET
; .FEND
;void main (void)
; 0000 0164 {
_main:
; .FSTART _main
; 0000 0165 unsigned char i, k = 0;
; 0000 0166 unsigned int DD0, DD1, DD2, DD3, DD4, DD5;
; 0000 0167 static int c0, c1, c2, c3, c4, c5;
; 0000 0168 
; 0000 0169 Init_initController();  // this must be the first "init" action/call!
	SBIW R28,8
;	i -> R17
;	k -> R16
;	DD0 -> R18,R19
;	DD1 -> R20,R21
;	DD2 -> Y+6
;	DD3 -> Y+4
;	DD4 -> Y+2
;	DD5 -> Y+0
	LDI  R16,0
	RCALL _Init_initController
; 0000 016A #asm("sei")             // enable interrupts
	SEI
; 0000 016B LED1 = 1;               // initial state, will be changed by timer 1
	SBI  0xB,6
; 0000 016C 
; 0000 016D while (TRUE) {
_0x79:
; 0000 016E wdogtrig();            // call often else processor will reset
	WDR
; 0000 016F 
; 0000 0170 
; 0000 0171 // CALENDAR
; 0000 0172 if (SW4 == 0) {
	SBIC 0x3,1
	RJMP _0x7C
; 0000 0173 LED1 = 0;
	CBI  0xB,6
; 0000 0174 LED2 = 1;
	SBI  0xB,4
; 0000 0175 LED3 = 0;
	RCALL SUBOPT_0xF
; 0000 0176 LED4 = 0;
; 0000 0177 
; 0000 0178 delay_ms(30);   // debounce switch
; 0000 0179 if (SW4 == 0) {
	SBIC 0x3,1
	RJMP _0x85
; 0000 017A while (SW4 == 0) wdogtrig();    // wait for release
_0x86:
	SBIC 0x3,1
	RJMP _0x88
	WDR
; 0000 017B PORTA = 0x00;    // Turn OFF LEDs on PORTA
	RJMP _0x86
_0x88:
	LDI  R30,LOW(0)
	OUT  0x2,R30
; 0000 017C 
; 0000 017D do {
_0x8A:
; 0000 017E afisare(currentTime.zi, currentTime.luna, currentTime.an);
	RCALL SUBOPT_0x10
; 0000 017F 
; 0000 0180 if (SW3 == 0) break;
	SBIS 0x3,0
	RJMP _0x8B
; 0000 0181 if (SW5 == 0) break;
	SBIS 0x3,2
	RJMP _0x8B
; 0000 0182 if (SW6 == 0) break;
	SBIS 0x3,3
	RJMP _0x8B
; 0000 0183 
; 0000 0184 if (SW7 == 0) {
	SBIC 0x6,6
	RJMP _0x8F
; 0000 0185 delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
; 0000 0186 if (SW7 == 0) {
	SBIC 0x6,6
	RJMP _0x90
; 0000 0187 while (SW7 == 0) {
_0x91:
	SBIC 0x6,6
	RJMP _0x93
; 0000 0188 currentTime.luna ++;
	RCALL SUBOPT_0x11
; 0000 0189 afisare(currentTime.zi, currentTime.luna, currentTime.an);
	RCALL SUBOPT_0x10
; 0000 018A 
; 0000 018B if (SW3 == 0) break;
	SBIS 0x3,0
	RJMP _0x93
; 0000 018C if (SW4 == 0) break;
	SBIS 0x3,1
	RJMP _0x93
; 0000 018D if (SW5 == 0) break;
	SBIS 0x3,2
	RJMP _0x93
; 0000 018E if (SW6 == 0) break;
	SBIS 0x3,3
	RJMP _0x93
; 0000 018F }
	RJMP _0x91
_0x93:
; 0000 0190 }
; 0000 0191 else {
	RJMP _0x98
_0x90:
; 0000 0192 wdogtrig(); currentTime.luna++;
	WDR
	RCALL SUBOPT_0x11
; 0000 0193 
; 0000 0194 do {
_0x9A:
; 0000 0195 afisare(currentTime.zi, currentTime.luna, currentTime.an);
	RCALL SUBOPT_0x10
; 0000 0196 
; 0000 0197 if (SW3 == 0) break;
	SBIS 0x3,0
	RJMP _0x9B
; 0000 0198 if (SW4 == 0) break;
	SBIS 0x3,1
	RJMP _0x9B
; 0000 0199 if (SW5 == 0) break;
	SBIS 0x3,2
	RJMP _0x9B
; 0000 019A if (SW6 == 0) break;
	SBIS 0x3,3
	RJMP _0x9B
; 0000 019B if (SW7 == 0) break;
	SBIS 0x6,6
	RJMP _0x9B
; 0000 019C if (SW8 == 0) break;
	SBIS 0x6,7
	RJMP _0x9B
; 0000 019D 
; 0000 019E } while(1);
	RJMP _0x9A
_0x9B:
; 0000 019F }
_0x98:
; 0000 01A0 }
; 0000 01A1 
; 0000 01A2 if (SW8 == 0) {
_0x8F:
	SBIC 0x6,7
	RJMP _0xA2
; 0000 01A3 delay_ms(30);
	LDI  R26,LOW(30)
	LDI  R27,0
	RCALL _delay_ms
; 0000 01A4 if (SW8 == 0) {
	SBIC 0x6,7
	RJMP _0xA3
; 0000 01A5 while (SW8 == 0) {
_0xA4:
	SBIC 0x6,7
	RJMP _0xA6
; 0000 01A6 currentTime.zi ++;
	RCALL SUBOPT_0x3
; 0000 01A7 delay_ms(150);
	LDI  R26,LOW(150)
	LDI  R27,0
	RCALL _delay_ms
; 0000 01A8 afisare(currentTime.zi, currentTime.luna, currentTime.an);
	RCALL SUBOPT_0x10
; 0000 01A9 
; 0000 01AA if (SW3 == 0) break;
	SBIS 0x3,0
	RJMP _0xA6
; 0000 01AB if (SW4 == 0) break;
	SBIS 0x3,1
	RJMP _0xA6
; 0000 01AC if (SW5 == 0) break;
	SBIS 0x3,2
	RJMP _0xA6
; 0000 01AD if (SW6 == 0) break;
	SBIS 0x3,3
	RJMP _0xA6
; 0000 01AE }
	RJMP _0xA4
_0xA6:
; 0000 01AF }
; 0000 01B0 }
_0xA3:
; 0000 01B1 } while(1);          // endless loop
_0xA2:
	RJMP _0x8A
_0x8B:
; 0000 01B2 }
; 0000 01B3 }
_0x85:
; 0000 01B4 
; 0000 01B5 
; 0000 01B6 //ALARMA
; 0000 01B7 
; 0000 01B8 if (SW5 == 0) {
_0x7C:
	SBIC 0x3,2
	RJMP _0xAB
; 0000 01B9 LED1 = 0;
	CBI  0xB,6
; 0000 01BA LED2 = 0;
	CBI  0xB,4
; 0000 01BB LED3 = 1;
	SBI  0xB,3
; 0000 01BC LED4 = 0;
	CBI  0xB,2
; 0000 01BD 
; 0000 01BE delay_ms(30);   // debounce switch
	LDI  R26,LOW(30)
	LDI  R27,0
	RCALL _delay_ms
; 0000 01BF if (SW5 == 0) {
	SBIC 0x3,2
	RJMP _0xB4
; 0000 01C0 while (SW5 == 0) wdogtrig();    // wait for release
_0xB5:
	SBIC 0x3,2
	RJMP _0xB7
	WDR
; 0000 01C1 PORTA = cifra[10];    // Afisam caracterul A
	RJMP _0xB5
_0xB7:
	__GETB1MN _cifra,20
	OUT  0x2,R30
; 0000 01C2 afisaj_1 = 1;      // Selectie afisaj 1
	RCALL SUBOPT_0x8
; 0000 01C3 afisaj_2 = 0;
; 0000 01C4 afisaj_3 = 0;
; 0000 01C5 afisaj_4 = 0;
; 0000 01C6 afisaj_5 = 0;
; 0000 01C7 afisaj_6 = 0;
; 0000 01C8 
; 0000 01C9 delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 01CA 
; 0000 01CB do {
_0xC5:
; 0000 01CC afisare(alarmaTime.a_ora, alarmaTime.a_minut, alarmaTime.a_secunda);
	RCALL SUBOPT_0x12
; 0000 01CD 
; 0000 01CE if (SW3 == 0) break;
	SBIS 0x3,0
	RJMP _0xC6
; 0000 01CF if (SW4 == 0) break;
	SBIS 0x3,1
	RJMP _0xC6
; 0000 01D0 if (SW6 == 0) break;
	SBIS 0x3,3
	RJMP _0xC6
; 0000 01D1 if (SW7 == 0) {
	SBIC 0x6,6
	RJMP _0xCA
; 0000 01D2 delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
; 0000 01D3 if (SW7 == 0) {
	SBIC 0x6,6
	RJMP _0xCB
; 0000 01D4 while (SW7 == 0) {
_0xCC:
	SBIC 0x6,6
	RJMP _0xCE
; 0000 01D5 alarmaTime.a_minut++;
	RCALL SUBOPT_0x13
; 0000 01D6 
; 0000 01D7 if (alarmaTime.a_minut >= 60) {
	BRLO _0xCF
; 0000 01D8 alarmaTime.a_minut = 0;
	RCALL SUBOPT_0x14
; 0000 01D9 alarmaTime.a_ora ++;
; 0000 01DA }
; 0000 01DB 
; 0000 01DC if (alarmaTime.a_ora >= 24) {
_0xCF:
	LDS  R26,_alarmaTime_G000
	CPI  R26,LOW(0x18)
	BRLO _0xD0
; 0000 01DD alarmaTime.a_ora = 0;
	LDI  R30,LOW(0)
	STS  _alarmaTime_G000,R30
; 0000 01DE }
; 0000 01DF 
; 0000 01E0 minut_alarma = alarmaTime.a_minut;
_0xD0:
	RCALL SUBOPT_0x15
; 0000 01E1 ok=0;
; 0000 01E2 afisare(alarmaTime.a_ora, alarmaTime.a_minut, alarmaTime.a_secunda);
	RCALL SUBOPT_0x12
; 0000 01E3 
; 0000 01E4 if (SW3 == 0)break;
	SBIS 0x3,0
	RJMP _0xCE
; 0000 01E5 if (SW4 == 0)break;
	SBIS 0x3,1
	RJMP _0xCE
; 0000 01E6 if (SW6 == 0)break;
	SBIS 0x3,3
	RJMP _0xCE
; 0000 01E7 // if(SW5 == 0)break;
; 0000 01E8 }
	RJMP _0xCC
_0xCE:
; 0000 01E9 }
; 0000 01EA else {
	RJMP _0xD4
_0xCB:
; 0000 01EB wdogtrig();
	WDR
; 0000 01EC alarmaTime.a_minut++;
	RCALL SUBOPT_0x13
; 0000 01ED 
; 0000 01EE if (alarmaTime.a_minut >= 60) {
	BRLO _0xD5
; 0000 01EF alarmaTime.a_minut = 0;
	RCALL SUBOPT_0x14
; 0000 01F0 alarmaTime.a_ora ++;
; 0000 01F1 }
; 0000 01F2 
; 0000 01F3 if (alarmaTime.a_ora >= 24) {
_0xD5:
	LDS  R26,_alarmaTime_G000
	CPI  R26,LOW(0x18)
	BRLO _0xD6
; 0000 01F4 alarmaTime.a_ora = 0;
	LDI  R30,LOW(0)
	STS  _alarmaTime_G000,R30
; 0000 01F5 }
; 0000 01F6 
; 0000 01F7 minut_alarma = alarmaTime.a_minut;
_0xD6:
	RCALL SUBOPT_0x15
; 0000 01F8 ok=0;
; 0000 01F9 
; 0000 01FA do {
_0xD8:
; 0000 01FB afisare(alarmaTime.a_ora, alarmaTime.a_minut, alarmaTime.a_secunda);
	RCALL SUBOPT_0x12
; 0000 01FC 
; 0000 01FD if (SW3 == 0) break;
	SBIS 0x3,0
	RJMP _0xD9
; 0000 01FE if (SW4 == 0) break;
	SBIS 0x3,1
	RJMP _0xD9
; 0000 01FF if (SW5 == 0) break;
	SBIS 0x3,2
	RJMP _0xD9
; 0000 0200 if (SW6 == 0) break;
	SBIS 0x3,3
	RJMP _0xD9
; 0000 0201 if (SW8 == 0) break;
	SBIS 0x6,7
	RJMP _0xD9
; 0000 0202 if (SW7 == 0) break;
	SBIS 0x6,6
	RJMP _0xD9
; 0000 0203 } while(1);
	RJMP _0xD8
_0xD9:
; 0000 0204 }
_0xD4:
; 0000 0205 }
; 0000 0206 
; 0000 0207 if (SW8 == 0) {
_0xCA:
	SBIC 0x6,7
	RJMP _0xE0
; 0000 0208 delay_ms(30);
	LDI  R26,LOW(30)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0209 if (SW8 == 0) {
	SBIC 0x6,7
	RJMP _0xE1
; 0000 020A while (SW8 == 0) {
_0xE2:
	SBIC 0x6,7
	RJMP _0xE4
; 0000 020B alarmaTime.a_ora ++;
	LDS  R30,_alarmaTime_G000
	SUBI R30,-LOW(1)
	STS  _alarmaTime_G000,R30
; 0000 020C 
; 0000 020D if (alarmaTime.a_minut >= 60) {
	__GETB2MN _alarmaTime_G000,1
	CPI  R26,LOW(0x3C)
	BRLO _0xE5
; 0000 020E alarmaTime.a_minut = 0;
	RCALL SUBOPT_0x14
; 0000 020F alarmaTime.a_ora ++;
; 0000 0210 }
; 0000 0211 
; 0000 0212 if (alarmaTime.a_ora >= 24) {
_0xE5:
	LDS  R26,_alarmaTime_G000
	CPI  R26,LOW(0x18)
	BRLO _0xE6
; 0000 0213 alarmaTime.a_ora = 0;
	LDI  R30,LOW(0)
	STS  _alarmaTime_G000,R30
; 0000 0214 
; 0000 0215 }
; 0000 0216 
; 0000 0217 delay_ms(150);
_0xE6:
	LDI  R26,LOW(150)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0218 ora_alarma = alarmaTime.a_ora;
	LDS  R10,_alarmaTime_G000
	CLR  R11
; 0000 0219 ok=0;
	CLR  R12
	CLR  R13
; 0000 021A afisare(alarmaTime.a_ora, alarmaTime.a_minut, alarmaTime.a_secunda);
	RCALL SUBOPT_0x12
; 0000 021B 
; 0000 021C if (SW3 == 0) break;
	SBIS 0x3,0
	RJMP _0xE4
; 0000 021D if (SW4 == 0) break;
	SBIS 0x3,1
	RJMP _0xE4
; 0000 021E if (SW5 == 0) break;
	SBIS 0x3,2
	RJMP _0xE4
; 0000 021F if (SW6 == 0) break;
	SBIS 0x3,3
	RJMP _0xE4
; 0000 0220 }
	RJMP _0xE2
_0xE4:
; 0000 0221 }
; 0000 0222 }
_0xE1:
; 0000 0223 } while(1);          // endless loop
_0xE0:
	RJMP _0xC5
_0xC6:
; 0000 0224 }
; 0000 0225 }
_0xB4:
; 0000 0226 
; 0000 0227 
; 0000 0228 //CRONOMETRU
; 0000 0229 
; 0000 022A if (SW6 == 0) {
_0xAB:
	SBIC 0x3,3
	RJMP _0xEB
; 0000 022B LED1 = 0;
	CBI  0xB,6
; 0000 022C LED2 = 0;
	CBI  0xB,4
; 0000 022D LED3 = 0;
	CBI  0xB,3
; 0000 022E LED4 = 1;
	SBI  0xB,2
; 0000 022F 
; 0000 0230 delay_ms(30);   // debounce switch
	LDI  R26,LOW(30)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0231 if (SW6 == 0) {
	SBIC 0x3,3
	RJMP _0xF4
; 0000 0232 while (SW6 == 0) wdogtrig();    // wait for release
_0xF5:
	SBIC 0x3,3
	RJMP _0xF7
	WDR
; 0000 0233 k++;
	RJMP _0xF5
_0xF7:
	SUBI R16,-1
; 0000 0234 
; 0000 0235 PORTA = 0x39;      //Afisam caracterul C
	LDI  R30,LOW(57)
	OUT  0x2,R30
; 0000 0236 afisaj_1 = 1;      // Selectie afisaj 1
	RCALL SUBOPT_0x8
; 0000 0237 afisaj_2 = 0;
; 0000 0238 afisaj_3 = 0;
; 0000 0239 afisaj_4 = 0;
; 0000 023A afisaj_5 = 0;
; 0000 023B afisaj_6 = 0;
; 0000 023C 
; 0000 023D 
; 0000 023E //Pornire cronometru
; 0000 023F if (k == 2) {
	CPI  R16,2
	BRNE _0x104
; 0000 0240 cronometruTime.c_ora = 0;
	LDI  R30,LOW(0)
	STS  _cronometruTime_G000,R30
; 0000 0241 cronometruTime.c_minut = 0;
	__PUTB1MN _cronometruTime_G000,1
; 0000 0242 cronometruTime.c_secunda = 0;
	__PUTB1MN _cronometruTime_G000,2
; 0000 0243 
; 0000 0244 do {
_0x106:
; 0000 0245 afisare(cronometruTime.c_ora, cronometruTime.c_minut, cronometruTime.c_secunda);
	LDS  R30,_cronometruTime_G000
	ST   -Y,R30
	__GETB1MN _cronometruTime_G000,1
	ST   -Y,R30
	__GETB2MN _cronometruTime_G000,2
	RCALL _afisare
; 0000 0246 
; 0000 0247 if (SW3 == 0) break;
	SBIS 0x3,0
	RJMP _0x107
; 0000 0248 if (SW4 == 0) break;
	SBIS 0x3,1
	RJMP _0x107
; 0000 0249 if (SW5 == 0) break;
	SBIS 0x3,2
	RJMP _0x107
; 0000 024A if (SW6 == 0) break;
	SBIS 0x3,3
	RJMP _0x107
; 0000 024B if (SW7 == 0) break;
	SBIS 0x6,6
	RJMP _0x107
; 0000 024C if (SW8 == 0) break;
	SBIS 0x6,7
	RJMP _0x107
; 0000 024D } while(1);          // endless loop
	RJMP _0x106
_0x107:
; 0000 024E }
; 0000 024F 
; 0000 0250 
; 0000 0251 //Oprire cronometru
; 0000 0252 if (k == 3) {
_0x104:
	CPI  R16,3
	BREQ PC+2
	RJMP _0x10E
; 0000 0253 k = 0;
	LDI  R16,LOW(0)
; 0000 0254 
; 0000 0255 c0 = cronometruTime.c_ora/10;         // led 1
	LDS  R26,_cronometruTime_G000
	LDI  R30,LOW(10)
	RCALL __DIVB21U
	LDI  R31,0
	STS  _c0_S0000006000,R30
	STS  _c0_S0000006000+1,R31
; 0000 0256 c1 = cronometruTime.c_ora%10;         // led 2
	LDS  R26,_cronometruTime_G000
	LDI  R30,LOW(10)
	RCALL __MODB21U
	LDI  R31,0
	STS  _c1_S0000006000,R30
	STS  _c1_S0000006000+1,R31
; 0000 0257 c2 = cronometruTime.c_minut/10;       // led 3
	__GETB2MN _cronometruTime_G000,1
	LDI  R30,LOW(10)
	RCALL __DIVB21U
	LDI  R31,0
	STS  _c2_S0000006000,R30
	STS  _c2_S0000006000+1,R31
; 0000 0258 c3 = cronometruTime.c_minut%10;       // led 4
	__GETB2MN _cronometruTime_G000,1
	LDI  R30,LOW(10)
	RCALL __MODB21U
	LDI  R31,0
	STS  _c3_S0000006000,R30
	STS  _c3_S0000006000+1,R31
; 0000 0259 c4 = cronometruTime.c_secunda/10;     // led 5
	__GETB2MN _cronometruTime_G000,2
	LDI  R30,LOW(10)
	RCALL __DIVB21U
	LDI  R31,0
	STS  _c4_S0000006000,R30
	STS  _c4_S0000006000+1,R31
; 0000 025A c5 = cronometruTime.c_secunda%10;     // led 6
	__GETB2MN _cronometruTime_G000,2
	LDI  R30,LOW(10)
	RCALL __MODB21U
	LDI  R31,0
	STS  _c5_S0000006000,R30
	STS  _c5_S0000006000+1,R31
; 0000 025B 
; 0000 025C do {
_0x110:
; 0000 025D DD0 = cifra[c0];
	LDS  R30,_c0_S0000006000
	LDS  R31,_c0_S0000006000+1
	RCALL SUBOPT_0x5
	LD   R18,X+
	LD   R19,X
; 0000 025E DD1 = cifra[c1];
	LDS  R30,_c1_S0000006000
	LDS  R31,_c1_S0000006000+1
	RCALL SUBOPT_0x5
	LD   R20,X+
	LD   R21,X
; 0000 025F DD2 = cifra[c2];
	LDS  R30,_c2_S0000006000
	LDS  R31,_c2_S0000006000+1
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0x16
; 0000 0260 DD3 = cifra[c3];
	LDS  R30,_c3_S0000006000
	LDS  R31,_c3_S0000006000+1
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0x17
; 0000 0261 DD4 = cifra[c4];
	LDS  R30,_c4_S0000006000
	LDS  R31,_c4_S0000006000+1
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0x18
; 0000 0262 DD5 = cifra[c5];
	LDS  R30,_c5_S0000006000
	LDS  R31,_c5_S0000006000+1
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0x19
; 0000 0263 
; 0000 0264 for (i = 0; i <= 10; i++) {
_0x113:
	CPI  R17,11
	BRSH _0x114
; 0000 0265 PORTA = DD0;
	OUT  0x2,R18
; 0000 0266 afisaj_1 = 1;      // Selectie afisaj 1
	RCALL SUBOPT_0x8
; 0000 0267 afisaj_2 = 0;
; 0000 0268 afisaj_3 = 0;
; 0000 0269 afisaj_4 = 0;
; 0000 026A afisaj_5 = 0;
; 0000 026B afisaj_6 = 0;
; 0000 026C delay_ms(1);
	RCALL SUBOPT_0x1A
; 0000 026D 
; 0000 026E PORTA = DD1;
; 0000 026F afisaj_1 = 0;      // Selectie afisaj 2
; 0000 0270 afisaj_2 = 1;
; 0000 0271 afisaj_3 = 0;
; 0000 0272 afisaj_4 = 0;
; 0000 0273 afisaj_5 = 0;
; 0000 0274 afisaj_6 = 0;
; 0000 0275 delay_ms(1);
; 0000 0276 
; 0000 0277 PORTA = DD2;
	LDD  R30,Y+6
	OUT  0x2,R30
; 0000 0278 afisaj_1 = 0;      // Selectie afisaj 3
	RCALL SUBOPT_0xA
; 0000 0279 afisaj_2 = 0;
; 0000 027A afisaj_3 = 1;
; 0000 027B afisaj_4 = 0;
; 0000 027C afisaj_5 = 0;
; 0000 027D afisaj_6 = 0;
; 0000 027E delay_ms(1);
; 0000 027F 
; 0000 0280 PORTA = DD3;
	LDD  R30,Y+4
	RCALL SUBOPT_0xB
; 0000 0281 afisaj_1 = 0;      // Selectie afisaj 4
; 0000 0282 afisaj_2 = 0;
; 0000 0283 afisaj_3 = 0;
; 0000 0284 afisaj_4 = 1;
	RCALL SUBOPT_0xC
; 0000 0285 afisaj_5 = 0;
; 0000 0286 afisaj_6 = 0;
; 0000 0287 delay_ms(1);
; 0000 0288 
; 0000 0289 PORTA = DD4;
	LDD  R30,Y+2
	RCALL SUBOPT_0xB
; 0000 028A afisaj_1 = 0;      // Selectie afisaj 5
; 0000 028B afisaj_2 = 0;
; 0000 028C afisaj_3 = 0;
; 0000 028D afisaj_4 = 0;
	RCALL SUBOPT_0xD
; 0000 028E afisaj_5 = 1;
; 0000 028F afisaj_6 = 0;
; 0000 0290 delay_ms(1);
; 0000 0291 
; 0000 0292 PORTA = DD5;
	LD   R30,Y
	RCALL SUBOPT_0xB
; 0000 0293 afisaj_1 = 0;      // Selectie afisaj 6
; 0000 0294 afisaj_2 = 0;
; 0000 0295 afisaj_3 = 0;
; 0000 0296 afisaj_4 = 0;
	RCALL SUBOPT_0xE
; 0000 0297 afisaj_5 = 0;
; 0000 0298 afisaj_6 = 1;
; 0000 0299 delay_ms(1);
; 0000 029A }
	SUBI R17,-1
	RJMP _0x113
_0x114:
; 0000 029B 
; 0000 029C if (SW3 == 0) break;
	SBIS 0x3,0
	RJMP _0x111
; 0000 029D if (SW4 == 0) break;
	SBIS 0x3,1
	RJMP _0x111
; 0000 029E if (SW5 == 0) break;
	SBIS 0x3,2
	RJMP _0x111
; 0000 029F if (SW6 == 0) break;
	SBIS 0x3,3
	RJMP _0x111
; 0000 02A0 } while(1);          // endless loop
	RJMP _0x110
_0x111:
; 0000 02A1 }
; 0000 02A2 }
_0x10E:
; 0000 02A3 }
_0xF4:
; 0000 02A4 
; 0000 02A5 
; 0000 02A6 //CEAS
; 0000 02A7 if (SW3 == 0) {
_0xEB:
	SBIC 0x3,0
	RJMP _0x161
; 0000 02A8 LED1 = 1;
	SBI  0xB,6
; 0000 02A9 LED2 = 0;
	CBI  0xB,4
; 0000 02AA LED3 = 0;
	RCALL SUBOPT_0xF
; 0000 02AB LED4 = 0;
; 0000 02AC 
; 0000 02AD delay_ms(30);   // debounce switch
; 0000 02AE if (SW3 == 0) {
	SBIC 0x3,0
	RJMP _0x16A
; 0000 02AF while (SW3 == 0) wdogtrig();    // wait for release
_0x16B:
	SBIC 0x3,0
	RJMP _0x16D
	WDR
; 0000 02B0 
; 0000 02B1 PORTA = 0x00;    // Turn OFF LEDs on PORTA
	RJMP _0x16B
_0x16D:
	LDI  R30,LOW(0)
	OUT  0x2,R30
; 0000 02B2 
; 0000 02B3 do {
_0x16F:
; 0000 02B4 
; 0000 02B5 DD0 = currentTime.ora/10;      // led 1
	__GETB2MN _currentTime_G000,3
	LDI  R30,LOW(10)
	RCALL __DIVB21U
	RCALL SUBOPT_0x6
; 0000 02B6 DD0 = cifra[DD0];
	LD   R18,X+
	LD   R19,X
; 0000 02B7 
; 0000 02B8 DD1 = currentTime.ora%10;      // led 2
	__GETB2MN _currentTime_G000,3
	LDI  R30,LOW(10)
	RCALL __MODB21U
	RCALL SUBOPT_0x7
; 0000 02B9 DD1 = cifra[DD1];
	LD   R20,X+
	LD   R21,X
; 0000 02BA 
; 0000 02BB DD2 = currentTime.minut/10;    // led 3
	__GETB2MN _currentTime_G000,4
	LDI  R30,LOW(10)
	RCALL __DIVB21U
	LDI  R31,0
	STD  Y+6,R30
	STD  Y+6+1,R31
; 0000 02BC DD2 = cifra[DD2];
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0x16
; 0000 02BD 
; 0000 02BE DD3 = currentTime.minut%10;    // led 4
	__GETB2MN _currentTime_G000,4
	LDI  R30,LOW(10)
	RCALL __MODB21U
	LDI  R31,0
	STD  Y+4,R30
	STD  Y+4+1,R31
; 0000 02BF DD3 = cifra[DD3];
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0x17
; 0000 02C0 
; 0000 02C1 DD4 = currentTime.secunda/10;  // led 5
	__GETB2MN _currentTime_G000,5
	LDI  R30,LOW(10)
	RCALL __DIVB21U
	LDI  R31,0
	STD  Y+2,R30
	STD  Y+2+1,R31
; 0000 02C2 DD4 = cifra[DD4];
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0x18
; 0000 02C3 
; 0000 02C4 DD5 = currentTime.secunda%10;  // led 6
	__GETB2MN _currentTime_G000,5
	LDI  R30,LOW(10)
	RCALL __MODB21U
	LDI  R31,0
	ST   Y,R30
	STD  Y+1,R31
; 0000 02C5 DD5 = cifra[DD5];
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0x19
; 0000 02C6 
; 0000 02C7 
; 0000 02C8 for (i = 0; i<=10; i++) {
_0x172:
	CPI  R17,11
	BRLO PC+2
	RJMP _0x173
; 0000 02C9 PORTA = DD0;
	OUT  0x2,R18
; 0000 02CA afisaj_1 = 1;      // Selectie afisaj 1
	RCALL SUBOPT_0x8
; 0000 02CB afisaj_2 = 0;
; 0000 02CC afisaj_3 = 0;
; 0000 02CD afisaj_4 = 0;
; 0000 02CE afisaj_5 = 0;
; 0000 02CF afisaj_6 = 0;
; 0000 02D0 delay_ms(1);
	RCALL SUBOPT_0x1A
; 0000 02D1 
; 0000 02D2 PORTA = DD1;
; 0000 02D3 afisaj_1 = 0;      // Selectie afisaj 2
; 0000 02D4 afisaj_2 = 1;
; 0000 02D5 afisaj_3 = 0;
; 0000 02D6 afisaj_4 = 0;
; 0000 02D7 afisaj_5 = 0;
; 0000 02D8 afisaj_6 = 0;
; 0000 02D9 delay_ms(1);
; 0000 02DA 
; 0000 02DB PORTA = DD2;
	LDD  R30,Y+6
	OUT  0x2,R30
; 0000 02DC afisaj_1 = 0;      // Selectie afisaj 3
	RCALL SUBOPT_0xA
; 0000 02DD afisaj_2 = 0;
; 0000 02DE afisaj_3 = 1;
; 0000 02DF afisaj_4 = 0;
; 0000 02E0 afisaj_5 = 0;
; 0000 02E1 afisaj_6 = 0;
; 0000 02E2 delay_ms(1);
; 0000 02E3 
; 0000 02E4 PORTA = DD3;
	LDD  R30,Y+4
	RCALL SUBOPT_0xB
; 0000 02E5 afisaj_1 = 0;      // Selectie afisaj 4
; 0000 02E6 afisaj_2 = 0;
; 0000 02E7 afisaj_3 = 0;
; 0000 02E8 afisaj_4 = 1;
	RCALL SUBOPT_0xC
; 0000 02E9 afisaj_5 = 0;
; 0000 02EA afisaj_6 = 0;
; 0000 02EB delay_ms(1);
; 0000 02EC 
; 0000 02ED PORTA = DD4;
	LDD  R30,Y+2
	RCALL SUBOPT_0xB
; 0000 02EE afisaj_1 = 0;      // Selectie afisaj 5
; 0000 02EF afisaj_2 = 0;
; 0000 02F0 afisaj_3 = 0;
; 0000 02F1 afisaj_4 = 0;
	RCALL SUBOPT_0xD
; 0000 02F2 afisaj_5 = 1;
; 0000 02F3 afisaj_6 = 0;
; 0000 02F4 delay_ms(1);
; 0000 02F5 
; 0000 02F6 PORTA = DD5;
	LD   R30,Y
	RCALL SUBOPT_0xB
; 0000 02F7 afisaj_1 = 0;      // Selectie afisaj 6
; 0000 02F8 afisaj_2 = 0;
; 0000 02F9 afisaj_3 = 0;
; 0000 02FA afisaj_4 = 0;
	RCALL SUBOPT_0xE
; 0000 02FB afisaj_5 = 0;
; 0000 02FC afisaj_6 = 1;
; 0000 02FD delay_ms(1);
; 0000 02FE 
; 0000 02FF 
; 0000 0300 while((currentTime.minut == minut_alarma)&&(currentTime.ora == ora_alarma)&&(ok == 0))
_0x1BC:
	__GETB2MN _currentTime_G000,4
	MOVW R30,R8
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x1BF
	__GETB2MN _currentTime_G000,3
	MOVW R30,R10
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x1BF
	CLR  R0
	CP   R0,R12
	CPC  R0,R13
	BREQ _0x1C0
_0x1BF:
	RJMP _0x1BE
_0x1C0:
; 0000 0301 
; 0000 0302 {
; 0000 0303 while(1)
_0x1C1:
; 0000 0304 
; 0000 0305 {
; 0000 0306 for(i=0;i<10;i++){
	LDI  R17,LOW(0)
_0x1C5:
	CPI  R17,10
	BRSH _0x1C6
; 0000 0307 
; 0000 0308 buzzer = 1;
	SBI  0x5,5
; 0000 0309 delay_ms(1.6);
	RCALL SUBOPT_0x1B
; 0000 030A 
; 0000 030B buzzer = 0;
	CBI  0x5,5
; 0000 030C delay_ms(1.6);
	RCALL SUBOPT_0x1B
; 0000 030D 
; 0000 030E if(SW3 == 0) break;
	SBIS 0x3,0
	RJMP _0x1C6
; 0000 030F if(SW4 == 0) break;
	SBIS 0x3,1
	RJMP _0x1C6
; 0000 0310 if(SW5 == 0) break;
	SBIS 0x3,2
	RJMP _0x1C6
; 0000 0311 if(SW6 == 0) break;
	SBIS 0x3,3
	RJMP _0x1C6
; 0000 0312 }
	SUBI R17,-1
	RJMP _0x1C5
_0x1C6:
; 0000 0313 
; 0000 0314 for(i=0;i<10;i++){
	LDI  R17,LOW(0)
_0x1D0:
	CPI  R17,10
	BRSH _0x1D1
; 0000 0315 
; 0000 0316 buzzer = 1;
	SBI  0x5,5
; 0000 0317 delay_ms(1);
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0318 
; 0000 0319 buzzer = 0;
	CBI  0x5,5
; 0000 031A delay_ms(1);
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
; 0000 031B 
; 0000 031C if(SW3 == 0) break;
	SBIS 0x3,0
	RJMP _0x1D1
; 0000 031D if(SW4 == 0) break;
	SBIS 0x3,1
	RJMP _0x1D1
; 0000 031E if(SW5 == 0) break;
	SBIS 0x3,2
	RJMP _0x1D1
; 0000 031F if(SW6 == 0) break;
	SBIS 0x3,3
	RJMP _0x1D1
; 0000 0320 }
	SUBI R17,-1
	RJMP _0x1D0
_0x1D1:
; 0000 0321 
; 0000 0322 for(i=0;i<10;i++){
	LDI  R17,LOW(0)
_0x1DB:
	CPI  R17,10
	BRSH _0x1DC
; 0000 0323 
; 0000 0324 buzzer = 1;
	SBI  0x5,5
; 0000 0325 delay_ms(2.5);
	RCALL SUBOPT_0x1C
; 0000 0326 
; 0000 0327 buzzer = 0;
	CBI  0x5,5
; 0000 0328 delay_ms(2.5);
	RCALL SUBOPT_0x1C
; 0000 0329 
; 0000 032A if(SW3 == 0) break;
	SBIS 0x3,0
	RJMP _0x1DC
; 0000 032B if(SW4 == 0) break;
	SBIS 0x3,1
	RJMP _0x1DC
; 0000 032C if(SW5 == 0) break;
	SBIS 0x3,2
	RJMP _0x1DC
; 0000 032D if(SW6 == 0) break;
	SBIS 0x3,3
	RJMP _0x1DC
; 0000 032E }
	SUBI R17,-1
	RJMP _0x1DB
_0x1DC:
; 0000 032F 
; 0000 0330 
; 0000 0331 if(SW3 == 0) break;
	SBIS 0x3,0
	RJMP _0x1C3
; 0000 0332 if(SW4 == 0) break;
	SBIS 0x3,1
	RJMP _0x1C3
; 0000 0333 if(SW5 == 0) break;
	SBIS 0x3,2
	RJMP _0x1C3
; 0000 0334 if(SW6 == 0) break;
	SBIS 0x3,3
	RJMP _0x1C3
; 0000 0335 
; 0000 0336 
; 0000 0337 
; 0000 0338 }
	RJMP _0x1C1
_0x1C3:
; 0000 0339 
; 0000 033A if(SW5 == 0) {ok=1; break;}
	SBIC 0x3,2
	RJMP _0x1E9
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R12,R30
	RJMP _0x1BE
; 0000 033B 
; 0000 033C }
_0x1E9:
	RJMP _0x1BC
_0x1BE:
; 0000 033D 
; 0000 033E }
	SUBI R17,-1
	RJMP _0x172
_0x173:
; 0000 033F 
; 0000 0340 
; 0000 0341 if (SW4 == 0) break;
	SBIS 0x3,1
	RJMP _0x170
; 0000 0342 if (SW5 == 0) break;
	SBIS 0x3,2
	RJMP _0x170
; 0000 0343 if (SW6 == 0) break;
	SBIS 0x3,3
	RJMP _0x170
; 0000 0344 
; 0000 0345 if (SW7 == 0) {
	SBIC 0x6,6
	RJMP _0x1ED
; 0000 0346 delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
; 0000 0347 if (SW7 == 0) {
	SBIC 0x6,6
	RJMP _0x1EE
; 0000 0348 while (SW7 == 0) {
_0x1EF:
	SBIC 0x6,6
	RJMP _0x1F1
; 0000 0349 currentTime.minut ++;
	RCALL SUBOPT_0x1
; 0000 034A afisare(currentTime.ora, currentTime.minut, currentTime.secunda);
	RCALL SUBOPT_0x1D
; 0000 034B 
; 0000 034C 
; 0000 034D if (SW3 == 0) break;
	SBIS 0x3,0
	RJMP _0x1F1
; 0000 034E if (SW4 == 0) break;
	SBIS 0x3,1
	RJMP _0x1F1
; 0000 034F if (SW5 == 0) break;
	SBIS 0x3,2
	RJMP _0x1F1
; 0000 0350 if (SW6 == 0) break;
	SBIS 0x3,3
	RJMP _0x1F1
; 0000 0351 }
	RJMP _0x1EF
_0x1F1:
; 0000 0352 } else {
	RJMP _0x1F6
_0x1EE:
; 0000 0353 wdogtrig();
	WDR
; 0000 0354 currentTime.minut++;
	RCALL SUBOPT_0x1
; 0000 0355 
; 0000 0356 do {
_0x1F8:
; 0000 0357 afisare(currentTime.ora, currentTime.minut, currentTime.secunda);
	RCALL SUBOPT_0x1D
; 0000 0358 
; 0000 0359 if (SW3 == 0) break;
	SBIS 0x3,0
	RJMP _0x1F9
; 0000 035A if (SW4 == 0) break;
	SBIS 0x3,1
	RJMP _0x1F9
; 0000 035B if (SW5 == 0) break;
	SBIS 0x3,2
	RJMP _0x1F9
; 0000 035C if (SW6 == 0) break;
	SBIS 0x3,3
	RJMP _0x1F9
; 0000 035D if (SW7 == 0) break;
	SBIS 0x6,6
	RJMP _0x1F9
; 0000 035E if (SW8 == 0) break;
	SBIS 0x6,7
	RJMP _0x1F9
; 0000 035F } while(1);
	RJMP _0x1F8
_0x1F9:
; 0000 0360 }
_0x1F6:
; 0000 0361 }
; 0000 0362 
; 0000 0363 if (SW8 == 0) {
_0x1ED:
	SBIC 0x6,7
	RJMP _0x200
; 0000 0364 delay_ms(30);
	LDI  R26,LOW(30)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0365 if (SW8 == 0) {
	SBIC 0x6,7
	RJMP _0x201
; 0000 0366 while (SW8 == 0) {
_0x202:
	SBIC 0x6,7
	RJMP _0x204
; 0000 0367 currentTime.ora ++;
	RCALL SUBOPT_0x2
; 0000 0368 delay_ms(150);
	LDI  R26,LOW(150)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0369 afisare(currentTime.ora, currentTime.minut, currentTime.secunda);
	RCALL SUBOPT_0x1D
; 0000 036A 
; 0000 036B if (SW3 == 0) break;
	SBIS 0x3,0
	RJMP _0x204
; 0000 036C if (SW4 == 0) break;
	SBIS 0x3,1
	RJMP _0x204
; 0000 036D if (SW5 == 0) break;
	SBIS 0x3,2
	RJMP _0x204
; 0000 036E if (SW6 == 0) break;
	SBIS 0x3,3
	RJMP _0x204
; 0000 036F }
	RJMP _0x202
_0x204:
; 0000 0370 }
; 0000 0371 }
_0x201:
; 0000 0372 } while(1);          // endless loop
_0x200:
	RJMP _0x16F
_0x170:
; 0000 0373 }
; 0000 0374 }
_0x16A:
; 0000 0375 }
_0x161:
	RJMP _0x79
; 0000 0376 }// end main loop
_0x209:
	RJMP _0x209
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
;void Init_initController(void)
; 0001 000B {

	.CSEG
_Init_initController:
; .FSTART _Init_initController
; 0001 000C // Crystal Oscillator division factor: 1
; 0001 000D #pragma optsize-
; 0001 000E CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
; 0001 000F CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
; 0001 0010 #ifdef _OPTIMIZE_SIZE_
; 0001 0011 #pragma optsize+
; 0001 0012 #endif
; 0001 0013 
; 0001 0014 // Input/Output Ports initialization
; 0001 0015 // Port A initialization
; 0001 0016 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0001 0017 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0001 0018 PORTA=0x00;
	OUT  0x2,R30
; 0001 0019 DDRA=0b01111111;    // A.0, A.1, A.2, A.3, A.4, A.5, A.6 are LEDs (7 segments display)
	LDI  R30,LOW(127)
	OUT  0x1,R30
; 0001 001A 
; 0001 001B // Port B initialization
; 0001 001C PORTB=0b00001111;  //// B.0, B.1, B.2, B.3 need pull-up resistors (push buttons)
	LDI  R30,LOW(15)
	OUT  0x5,R30
; 0001 001D DDRB=0b00100000;  //buzzer
	LDI  R30,LOW(32)
	OUT  0x4,R30
; 0001 001E 
; 0001 001F // Port C initialization
; 0001 0020 PORTC=0b11000000;  // SW7, SW8 - C.6, C.7 need pull-up resistors (push buttons)
	LDI  R30,LOW(192)
	OUT  0x8,R30
; 0001 0021 DDRC=0x00;
	LDI  R30,LOW(0)
	OUT  0x7,R30
; 0001 0022 
; 0001 0023 // Port D initialization
; 0001 0024 PORTD=0b00100000; // D.5 needs pull-up resistor  (push buttons)
	LDI  R30,LOW(32)
	OUT  0xB,R30
; 0001 0025 DDRD= 0b01011100; // D.6, D.4, D.3, D.2 are LEDs
	LDI  R30,LOW(92)
	OUT  0xA,R30
; 0001 0026 
; 0001 0027 // Timer/Counter 0 initialization
; 0001 0028 // Clock source: System Clock
; 0001 0029 // Clock value: Timer 0 Stopped
; 0001 002A // Mode: Normal top=FFh
; 0001 002B // OC0 output: Disconnected
; 0001 002C TCCR0A=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0001 002D TCCR0B=0x00;
	OUT  0x25,R30
; 0001 002E TCNT0=0x00;
	OUT  0x26,R30
; 0001 002F OCR0A=0x00;
	OUT  0x27,R30
; 0001 0030 OCR0B=0x00;
	OUT  0x28,R30
; 0001 0031 
; 0001 0032 // Timer/Counter 1 initialization
; 0001 0033 // Clock source: System Clock
; 0001 0034 // Clock value: 19.531 kHz = CLOCK/256
; 0001 0035 // Mode: CTC top=OCR1A
; 0001 0036 // OC1A output: Discon.
; 0001 0037 // OC1B output: Discon.
; 0001 0038 // Noise Canceler: Off
; 0001 0039 // Input Capture on Falling Edge
; 0001 003A // Timer 1 Overflow Interrupt: Off
; 0001 003B // Input Capture Interrupt: Off
; 0001 003C // Compare A Match Interrupt: On
; 0001 003D // Compare B Match Interrupt: Off
; 0001 003E 
; 0001 003F TCCR1A=0x00;
	STS  128,R30
; 0001 0040 TCCR1B=0x0D;
	LDI  R30,LOW(13)
	STS  129,R30
; 0001 0041 TCNT1H=0x00;
	LDI  R30,LOW(0)
	STS  133,R30
; 0001 0042 TCNT1L=0x00;
	STS  132,R30
; 0001 0043 ICR1H=0x00;
	STS  135,R30
; 0001 0044 ICR1L=0x00;
	STS  134,R30
; 0001 0045 
; 0001 0046 // 1 sec = 19531 counts = 4C41H counts, from 0 to 4C40
; 0001 0047 // 4C40H = 4CH (MSB) and 40H (LSB)
; 0001 0048 OCR1AH=0x4C;
	LDI  R30,LOW(76)
	STS  137,R30
; 0001 0049 OCR1AL=0x40;
	LDI  R30,LOW(64)
	STS  136,R30
; 0001 004A 
; 0001 004B OCR1BH=0x00;
	LDI  R30,LOW(0)
	STS  139,R30
; 0001 004C OCR1BL=0x00;
	STS  138,R30
; 0001 004D 
; 0001 004E // Timer/Counter 2 initialization
; 0001 004F // Clock source: System Clock
; 0001 0050 // Clock value: Timer2 Stopped
; 0001 0051 // Mode: Normal top=0xFF
; 0001 0052 // OC2A output: Disconnected
; 0001 0053 // OC2B output: Disconnected
; 0001 0054 ASSR=0x00;
	STS  182,R30
; 0001 0055 TCCR2A=0x00;
	STS  176,R30
; 0001 0056 TCCR2B=0x00;
	STS  177,R30
; 0001 0057 TCNT2=0x00;
	STS  178,R30
; 0001 0058 OCR2A=0x00;
	STS  179,R30
; 0001 0059 OCR2B=0x00;
	STS  180,R30
; 0001 005A 
; 0001 005B // External Interrupt(s) initialization
; 0001 005C // INT0: Off
; 0001 005D // INT1: Off
; 0001 005E // INT2: Off
; 0001 005F // Interrupt on any change on pins PCINT0-7: Off
; 0001 0060 // Interrupt on any change on pins PCINT8-15: Off
; 0001 0061 // Interrupt on any change on pins PCINT16-23: Off
; 0001 0062 // Interrupt on any change on pins PCINT24-31: Off
; 0001 0063 EICRA=0x00;
	STS  105,R30
; 0001 0064 EIMSK=0x00;
	OUT  0x1D,R30
; 0001 0065 PCICR=0x00;
	STS  104,R30
; 0001 0066 
; 0001 0067 // Timer/Counter 0,1,2 Interrupt(s) initialization
; 0001 0068 TIMSK0=0x00;
	STS  110,R30
; 0001 0069 TIMSK1=0x02;
	LDI  R30,LOW(2)
	STS  111,R30
; 0001 006A TIMSK2=0x00;
	LDI  R30,LOW(0)
	STS  112,R30
; 0001 006B 
; 0001 006C // USART0 initialization
; 0001 006D // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0001 006E // USART0 Receiver: On
; 0001 006F // USART0 Transmitter: On
; 0001 0070 // USART0 Mode: Asynchronous
; 0001 0071 // USART0 Baud rate: 9600
; 0001 0072 UCSR0A=0x00;
	STS  192,R30
; 0001 0073 UCSR0B=0xD8;
	LDI  R30,LOW(216)
	STS  193,R30
; 0001 0074 UCSR0C=0x06;
	LDI  R30,LOW(6)
	STS  194,R30
; 0001 0075 UBRR0H=0x00;
	LDI  R30,LOW(0)
	STS  197,R30
; 0001 0076 UBRR0L=0x81;
	LDI  R30,LOW(129)
	STS  196,R30
; 0001 0077 
; 0001 0078 // USART1 initialization
; 0001 0079 // USART1 disabled
; 0001 007A UCSR1B=0x00;
	LDI  R30,LOW(0)
	STS  201,R30
; 0001 007B 
; 0001 007C 
; 0001 007D // Analog Comparator initialization
; 0001 007E // Analog Comparator: Off
; 0001 007F // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0001 0080 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0001 0081 ADCSRB=0x00;
	LDI  R30,LOW(0)
	STS  123,R30
; 0001 0082 DIDR1=0x00;
	STS  127,R30
; 0001 0083 
; 0001 0084 // Watchdog Timer initialization
; 0001 0085 // Watchdog Timer Prescaler: OSC/2048
; 0001 0086 #pragma optsize-
; 0001 0087 #asm("wdr")
	WDR
; 0001 0088 // Write 2 consecutive values to enable watchdog
; 0001 0089 // this is NOT a mistake !
; 0001 008A WDTCSR=0x18;
	LDI  R30,LOW(24)
	STS  96,R30
; 0001 008B WDTCSR=0x08;
	LDI  R30,LOW(8)
	STS  96,R30
; 0001 008C #ifdef _OPTIMIZE_SIZE_
; 0001 008D #pragma optsize+
; 0001 008E #endif
; 0001 008F 
; 0001 0090 }
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG

	.CSEG

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_rx_buffer0:
	.BYTE 0x8
_tx_buffer0:
	.BYTE 0x8
_cifra:
	.BYTE 0x16
_currentTime_G000:
	.BYTE 0x6
_cronometruTime_G000:
	.BYTE 0x3
_alarmaTime_G000:
	.BYTE 0x3
_c0_S0000006000:
	.BYTE 0x2
_c1_S0000006000:
	.BYTE 0x2
_c2_S0000006000:
	.BYTE 0x2
_c3_S0000006000:
	.BYTE 0x2
_c4_S0000006000:
	.BYTE 0x2
_c5_S0000006000:
	.BYTE 0x2
__seed_G102:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x1:
	__GETB1MN _currentTime_G000,4
	SUBI R30,-LOW(1)
	__PUTB1MN _currentTime_G000,4
	SUBI R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	__GETB1MN _currentTime_G000,3
	SUBI R30,-LOW(1)
	__PUTB1MN _currentTime_G000,3
	SUBI R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3:
	__GETB1MN _currentTime_G000,2
	SUBI R30,-LOW(1)
	__PUTB1MN _currentTime_G000,2
	SUBI R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(1)
	__PUTB1MN _currentTime_G000,2
	__GETB1MN _currentTime_G000,1
	SUBI R30,-LOW(1)
	__PUTB1MN _currentTime_G000,1
	SUBI R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 18 TIMES, CODE SIZE REDUCTION:83 WORDS
SUBOPT_0x5:
	LDI  R26,LOW(_cifra)
	LDI  R27,HIGH(_cifra)
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	MOV  R18,R30
	CLR  R19
	MOVW R30,R18
	RJMP SUBOPT_0x5

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	MOV  R20,R30
	CLR  R21
	MOVW R30,R20
	RJMP SUBOPT_0x5

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x8:
	SBI  0x8,5
	CBI  0x8,4
	CBI  0x8,3
	CBI  0x8,2
	CBI  0x8,1
	CBI  0x8,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x9:
	CBI  0x8,5
	SBI  0x8,4
	CBI  0x8,3
	CBI  0x8,2
	CBI  0x8,1
	CBI  0x8,0
	LDI  R26,LOW(1)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0xA:
	CBI  0x8,5
	CBI  0x8,4
	SBI  0x8,3
	CBI  0x8,2
	CBI  0x8,1
	CBI  0x8,0
	LDI  R26,LOW(1)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0xB:
	OUT  0x2,R30
	CBI  0x8,5
	CBI  0x8,4
	CBI  0x8,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xC:
	SBI  0x8,2
	CBI  0x8,1
	CBI  0x8,0
	LDI  R26,LOW(1)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xD:
	CBI  0x8,2
	SBI  0x8,1
	CBI  0x8,0
	LDI  R26,LOW(1)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xE:
	CBI  0x8,2
	CBI  0x8,1
	SBI  0x8,0
	LDI  R26,LOW(1)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xF:
	CBI  0xB,3
	CBI  0xB,2
	LDI  R26,LOW(30)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x10:
	__GETB1MN _currentTime_G000,2
	ST   -Y,R30
	__GETB1MN _currentTime_G000,1
	ST   -Y,R30
	LDS  R26,_currentTime_G000
	RJMP _afisare

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x11:
	__GETB1MN _currentTime_G000,1
	SUBI R30,-LOW(1)
	__PUTB1MN _currentTime_G000,1
	SUBI R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x12:
	LDS  R30,_alarmaTime_G000
	ST   -Y,R30
	__GETB1MN _alarmaTime_G000,1
	ST   -Y,R30
	__GETB2MN _alarmaTime_G000,2
	RJMP _afisare

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x13:
	__GETB1MN _alarmaTime_G000,1
	SUBI R30,-LOW(1)
	__PUTB1MN _alarmaTime_G000,1
	SUBI R30,LOW(1)
	__GETB2MN _alarmaTime_G000,1
	CPI  R26,LOW(0x3C)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x14:
	LDI  R30,LOW(0)
	__PUTB1MN _alarmaTime_G000,1
	LDS  R30,_alarmaTime_G000
	SUBI R30,-LOW(1)
	STS  _alarmaTime_G000,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x15:
	__GETBRMN 8,_alarmaTime_G000,1
	CLR  R9
	CLR  R12
	CLR  R13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x16:
	LD   R30,X+
	LD   R31,X+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x17:
	LD   R30,X+
	LD   R31,X+
	STD  Y+4,R30
	STD  Y+4+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x18:
	LD   R30,X+
	LD   R31,X+
	STD  Y+2,R30
	STD  Y+2+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x19:
	__GETW1P
	ST   Y,R30
	STD  Y+1,R31
	LDI  R17,LOW(0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1A:
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
	OUT  0x2,R20
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1B:
	__GETD1N 0x1
	MOVW R26,R30
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1C:
	__GETD1N 0x2
	MOVW R26,R30
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x1D:
	__GETB1MN _currentTime_G000,3
	ST   -Y,R30
	__GETB1MN _currentTime_G000,4
	ST   -Y,R30
	__GETB2MN _currentTime_G000,5
	RJMP _afisare

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__DIVB21U:
	CLR  R0
	LDI  R25,8
__DIVB21U1:
	LSL  R26
	ROL  R0
	SUB  R0,R30
	BRCC __DIVB21U2
	ADD  R0,R30
	RJMP __DIVB21U3
__DIVB21U2:
	SBR  R26,1
__DIVB21U3:
	DEC  R25
	BRNE __DIVB21U1
	MOV  R30,R26
	MOV  R26,R0
	RET

__MODB21U:
	RCALL __DIVB21U
	MOV  R30,R26
	RET

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x1388
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
