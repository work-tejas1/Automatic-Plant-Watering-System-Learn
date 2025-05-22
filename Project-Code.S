#define __SFR_OFFSET 0x00
#include "avr/io.h"
.global main

main:
  RCALL SPI_MAX7219_init
  LDI R16, 0xF8
  OUT DDRD, R16
  SBI DDRB, 0

DHT11_sensor:
loop:
    CBI PORTD, 3
    CBI PORTD, 4
    RCALL MAX7219_disp_text_temp_humid
    SBI DDRD, 7
    CBI PORTD, 7
    RCALL delay_20ms
    SBI PORTD, 7
    CBI DDRD, 7
w1: SBIC PIND, 7
    RJMP w1
w2: SBIS PIND, 7
    RJMP w2
w3: SBIC PIND, 7
    RJMP w3
    RCALL DHT11_reading
    MOV R25, R24
    RCALL DHT11_reading
    RCALL DHT11_reading
    MOV R28, R24
    LDI R29, 0x07
    LDI R30, 0x06
    RCALL binary2decimal
    MOV R28, R25
    LDI R29, 0x02
    LDI R30, 0x01
    RCALL binary2decimal
    RCALL delay_5s
    RJMP soil_sensor
    RJMP loop

soil_sensor:
  CLR R29
  SBIS PIND, 5
  RJMP soil_sensor_dry
  RCALL MAX7219_disp_text_moist
  RCALL delay_5s
  RJMP loop

soil_sensor_dry:
  INC R29
  RCALL MAX7219_disp_text_dry
  SBI PORTD, 4
  SBI PORTD, 3
  RCALL delay_5s
  RJMP loop

delay1_s:
    ldi r18, 82
    ldi r19, 43
    ldi r20, 0
L1: dec r20
    brne L1
    dec r19
    brne L1
    dec r18
    brne L1
    lpm
    nop
    RET

DHT11_reading:
    LDI R16, 8
    CLR R24
w4: SBIS PIND, 7
    RJMP w4
    RCALL delay_timer0
    SBIS PIND, 7
    RJMP skp
    SEC
    ROL R24
    RJMP w5
skp:LSL R24
w5: SBIC PIND, 7
    RJMP w5
    DEC R16
    BRNE w4
    RET

delay_20ms:
    LDI R21, 255
l3: LDI R22, 210
l4: LDI R23, 2
l5: DEC R23
    BRNE l5
    DEC R22
    BRNE l4
    DEC R21
    BRNE l3
    RET

delay_2s:
    LDI R21, 255
l6: LDI R22, 255
l7: LDI R23, 164
l8: DEC R23
    BRNE l8
    DEC R22
    BRNE l7
    DEC R21
    BRNE l6
    RET

delay_timer0:
    CLR R20
    OUT TCNT0, R20
    LDI R20, 100
    OUT OCR0A, R20
    LDI R20, 0b00001010
    OUT TCCR0B, R20
l2: IN R20, TIFR0
    SBRS R20, OCF0A
    RJMP l2
    CLR R20
    OUT TCCR0B, R20
    LDI R20, (1<<OCF0A)
    OUT TIFR0, R20
    RET

delay_5s:
    ldi r21, 2
    ldi r22, 150
    ldi r23, 216
    ldi r24, 9
l_5: dec r24
    brne l_5
    dec r23
    brne l_5
    dec r22
    brne l_5
    dec r21
    brne l_5
    RET

SPI_MAX7219_init:
.equ SCK, 5
.equ MOSI, 3
.equ SS, 2
      LDI R17, (1<<MOSI)|(1<<SCK)|(1<<SS)
      OUT DDRB, R17
      LDI R17, (1<<SPE)|(1<<MSTR)|(1<<SPR0)
      OUT SPCR, R17
      LDI R17, 0x0A
      LDI R18, 8
      RCALL send_bytes
      
      LDI R17, 0x0B
      LDI R18, 0x07
      RCALL send_bytes
      LDI R17, 0x0C
      LDI R18, 0x01
      RCALL send_bytes
      RET

MAX7219_disp_text_temp_humid:
      
      LDI R17, 0x09
      LDI R18, 0b01100011
      RCALL send_bytes
      LDI R17, 0x08
      LDI R18, 0x0F
      RCALL send_bytes
      LDI R17, 0x07
      LDI R18, 0x00
      RCALL send_bytes
      LDI R17, 0x06
      LDI R18, 0x00
      RCALL send_bytes
      LDI R17, 0x05
      LDI R18, 0x4E
      RCALL send_bytes
      LDI R17, 0x04
      LDI R18, 0x00
      RCALL send_bytes
      LDI R17, 0x03
      LDI R18, 0x17
      RCALL send_bytes
      LDI R17, 0x02
      LDI R18, 0x00
      RCALL send_bytes
      LDI R17, 0x01
      LDI R18, 0x00
      RCALL send_bytes
      LDI R17, 0x00
      LDI R18, 0x00
      RCALL send_bytes
      RET

MAX7219_disp_text_moist:
RCALL delay1_s
LDI R17, 0x09
LDI R18, 0b00000000
RCALL send_bytes
      LDI R17, 0x08
      LDI R18, 0b01110110
      RCALL send_bytes
      LDI R17, 0x07
      LDI R18, 0b01110000
      RCALL send_bytes
      LDI R17, 0x06
      LDI R18, 0x7E
      RCALL send_bytes
      LDI R17, 0x05
      LDI R18, 0x06
      RCALL send_bytes
      LDI R17, 0x04
      LDI R18, 0x5B
      RCALL send_bytes
      LDI R17, 0x03
      LDI R18, 0x0F
      RCALL send_bytes
      LDI R17, 0x02
      LDI R18, 0x00
      RCALL send_bytes
      LDI R17, 0x01
      LDI R18, 0x00
      RCALL send_bytes
      LDI R17, 0x00
      LDI R18, 0x00
      RCALL send_bytes
      RET

MAX7219_disp_text_dry:
      RCALL delay1_s
      LDI R17, 0x09
      LDI R18, 0b00000000
      RCALL send_bytes
      LDI R17, 0x08
      LDI R18, 0x3D
      RCALL send_bytes
      LDI R17, 0x07
      LDI R18, 0x05
      RCALL send_bytes
      LDI R17, 0x06
      LDI R18, 0x3B
      RCALL send_bytes
      LDI R17, 0x05
      LDI R18, 0x00
      RCALL send_bytes
      LDI R17, 0x04
      LDI R18, 0x00
      RCALL send_bytes
      LDI R17, 0x03
      LDI R18, 0x00
      RCALL send_bytes
      LDI R17, 0x02
      LDI R18, 0x00
      RCALL send_bytes
      LDI R17, 0x01
      LDI R18, 0x00
      RCALL send_bytes
      LDI R17, 0x00
      LDI R18, 0x00
      RCALL send_bytes
      RET

send_bytes:
      CBI PORTB, SS
      OUT SPDR, R17
ll2:  IN R19, SPSR
      SBRS R19, SPIF
      RJMP ll2
      OUT SPDR, R18
ll3:  IN R19, SPSR

      SBRS  R19, SPIF    
      RJMP  ll3             
      SBI   PORTB, SS  
      RET
    
binary2decimal:
      CLR   R26             
      CLR   R27             

l70:  CPI   R28, 100      
Ret:  BRMI  l80            
      INC   R26             
      SUBI  R28, 100     
      RJMP  l70

l80:  CPI   R28, 10         
      BRMI  dsp             
      INC   R27             
      SUBI  R28, 10      
      RJMP  l80

dsp:  MOV   R18, R27
      MOV   R17, R29        
      RCALL send_bytes    
      MOV   R18, R28
      MOV   R17, R30        
      RCALL send_bytes    

      RET