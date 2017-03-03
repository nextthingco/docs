# GR8 Pins in C.H.I.P. Pro

| Function | Pin Name | On C.H.I.P. Pro | Future Use | Multi2    | Multi3    | Multi4    | Multi5    | Multi6 | Multi7 |            | 
|----------|----------|-----------|------------|-----------|-----------|-----------|-----------|--------|--------|------------| 
| PB(21)   | PB0      |           | TWI0       | TWI0_SCK  |           |           |           |        |        |            | 
|          | PB1      |           | TWI0       | TWI0_SDA  |           |           |           |        |        |            | 
|          | PB2      | PWM0      |            | PWM0      | SPDIF_DO  |           |           | EINT16 |        |            | 
|          | PB3      |           | IR         | IR_TX     |           |           |           | EINT17 |        |            | 
|          | PB4      |           | IR         | IR_RX     |           |           |           | EINT18 |        |            | 
|          | PB5      | I2S       |            | I2S_MCLK  |           |           |           | EINT19 |        |            | 
|          | PB6      | I2S       |            | I2S_BCLK  |           |           |           | EINT20 |        |            | 
|          | PB7      | I2S       |            | I2S_LRCK  |           |           |           | EINT21 |        |            | 
|          | PB8      | I2S       |            | I2S_DO    |           |           |           | EINT22 |        |            | 
|          | PB9      | I2S       |            | I2S_DI    | SPDIF_DI  |           |           | EINT23 |        |            | 
|          | PB10     | SPDIF     |            | SPI2_CS1  | SPDIF_DO  |           |           | EINT24 |        |            | 
|          | PB11     |           | JTAG0      | SPI2_CS0  | JTAG_MS0  |           |           | EINT25 |        |            | 
|          | PB12     |           | JTAG0      | SPI2_CLK  | JTAG_CK0  |           |           | EINT26 |        |            | 
|          | PB13     |           | JTAG0      | SPI2_MOSI | JTAG_DO0  |           |           | EINT27 |        |            | 
|          | PB14     |           | JTAG0      | SPI2_MISO | JTAG_DI0  |           |           | EINT28 |        |            | 
|          | PB15     | TWI1      |            | TWI1_SCK  |           |           |           |        |        |            | 
|          | PB16     | TWI1      |            | TWI1_SDA  |           |           |           |        |        |            | 
|          | PB17     |           | TWI2       | TWI2_SCK  |           |           |           |        |        |            | 
|          | PB18     |           | TWI2       | TWI2_SDA  |           |           |           |        |        |            | 
| PC(20)   | PC0      | NAND      |            | NWE       | SPI0_MOSI |           |           |        |        |            | 
|          | PC1      | NAND      |            | NALE      | SPI0_MISO |           |           |        |        |            | 
|          | PC2      | NAND      |            | NCLE      | SPI0_CLK  |           |           |        |        |            | 
|          | PC3      | NAND      |            | NCE1      | SPI0_CS0  |           |           |        |        |            | 
|          | PC4      | NAND      |            | NCE0      |           |           |           |        |        |            | 
|          | PC5      | NAND      |            | NRE       |           |           |           |        |        |            | 
|          | PC6      | NAND      |            | NRB0      | SDC2_CMD  |           |           |        |        |            | 
|          | PC7      | NAND      |            | NRB1      | SDC2_CLK  |           |           |        |        |            | 
|          | PC8      | NAND      |            | NDQ0      | SDC2_D0   |           |           |        |        |            | 
|          | PC9      | NAND      |            | NDQ1      | SDC2_D1   |           |           |        |        |            | 
|          | PC10     | NAND      |            | NDQ2      | SDC2_D2   |           |           |        |        |            | 
|          | PC11     | NAND      |            | NDQ3      | SDC2_D3   |           |           |        |        |            | 
|          | PC12     | NAND      |            | NDQ4      | SDC2_D4   |           |           |        |        |            | 
|          | PC13     | NAND      |            | NDQ5      | SDC2_D5   |           |           |        |        |            | 
|          | PC14     | NAND      |            | NDQ6      | SDC2_D6   |           |           |        |        |            | 
|          | PC15     | NAND      |            | NDQ7      | SDC2_D7   |           |           |        |        |            | 
|          | PC19     | NAND      |            | NDQS      | UART2_RX  | UART3_RTS |           |        |        |            | 
|          | PD2      | UART2     | LCD        | LCD_D2    | UART2_TX  |           |           |        |        |            | 
|          | PD3      | UART2     | LCD        | LCD_D3    | UART2_RX  |           |           |        |        |            | 
|          | PD4      | UART2     | LCD        | LCD_D4    | UART2_CTS |           |           |        |        |            | 
|          | PD5      | UART2     | LCD        | LCD_D5    | UART2_RTS |           |           |        |        |            | 
|          | PD6      |           | LCD        | LCD_D6    | ECRS      |           |           |        |        |            | 
|          | PD7      |           | LCD        | LCD_D7    | ECOL      |           |           |        |        |            | 
|          | PD10     |           | LCD        | LCD_D10   | ERXD0     |           |           |        |        |            | 
|          | PD11     |           | LCD        | LCD_D11   | ERXD1     |           |           |        |        |            | 
|          | PD12     |           | LCD        | LCD_D12   | ERXD2     |           |           |        |        |            | 
|          | PD13     |           | LCD        | LCD_D13   | ERXD3     |           |           |        |        |            | 
|          | PD14     |           | LCD        | LCD_D14   | ERXCK     |           |           |        |        |            | 
|          | PD15     |           | LCD        | LCD_D15   | ERXERR    |           |           |        |        |            | 
|          | PD18     |           | LCD        | LCD_D18   | ERXDV     |           |           |        |        |            | 
|          | PD19     |           | LCD        | LCD_D19   | ETXD0     |           |           |        |        |            | 
|          | PD20     |           | LCD        | LCD_D20   | ETXD1     |           |           |        |        |            | 
|          | PD21     |           | LCD        | LCD_D21   | ETXD2     |           |           |        |        |            | 
|          | PD22     |           | LCD        | LCD_D22   | ETXD3     |           |           |        |        |            | 
|          | PD23     |           | LCD        | LCD_D23   | ETXEN     |           |           |        |        |            | 
|          | PD24     |           | LCD        | LCD_CLK   | ETXCK     |           |           |        |        |            | 
|          | PD25     |           | LCD        | LCD_DE    | ETXERR    |           |           |        |        |            | 
|          | PD26     |           | LCD        | LCD_HSYNC | EMDC      |           |           |        |        |            | 
|          | PD27     |           | LCD        | LCD_VSYNC | EMDIO     |           |           |        |        |            | 
| PE(12)   | PE0      | SPI2      | CSI        | TS_CLK    | CSI_PCLK  | SPI2_CS0  |           | EINT14 |        |            | 
|          | PE1      | SPI2      | CSI        | TS_ERR    | CSI_MCLK  | SPI2_CLK  |           | EINT15 |        |            | 
|          | PE2      | SPI2      | CSI        | TS_SYNC   | CSI_HSYNC | SPI2_MOSI |           |        |        |            | 
|          | PE3      | SPI2      | CSI        | TS_DVLD   | CSI_VSYNC | SPI2_MISO |           |        |        |            | 
|          | PE4      | SDC2      | CSI        | TS_D0     | CSI_D0    | SDC2_D0   |           |        |        |            | 
|          | PE5      | SDC2      | CSI        | TS_D1     | CSI_D1    | SDC2_D1   |           |        |        |            | 
|          | PE6      | SDC2      | CSI        | TS_D2     | CSI_D2    | SDC2_D2   |           |        |        |            | 
|          | PE7      | SDC2      | CSI        | TS_D3     | CSI_D3    | SDC2_D3   |           |        |        |            | 
|          | PE8      | SDC2      | CSI        | TS_D4     | CSI_D4    | SDC2_CMD  |           |        |        |            | 
|          | PE9      | SDC2      | CSI        | TS_D5     | CSI_D5    | SDC2_CLK  |           |        |        |            | 
|          | PE10     | UART1     | CSI        | TS_D6     | CSI_D6    | UART1_TX  |           |        |        |            | 
|          | PE11     | UART1     | CSI        | TS_D7     | CSI_D7    | UART1_RX  |           |        |        |            | 
| PF(6)    | PF0      |           | SDC0       | SDC0_D1   |           | JTAG_MS1  |           |        |        |            | 
|          | PF1      |           | SDC0       | SDC0_D0   |           | JTAG_DI1  |           |        |        |            | 
|          | PF2      |           | SDC0       | SDC0_CLK  |           | UART0_TX  |           |        |        |            | 
|          | PF3      |           | SDC0       | SDC0_CMD  |           | JTAG_DO1  |           |        |        |            | 
|          | PF4      |           | SDC0       | SDC0_D3   |           | UART0_RX  |           |        |        |            | 
|          | PF5      |           | SDC0       | SDC0_D2   |           | JTAG_CK1  |           |        |        |            | 
| PG(14)   | PG0      |           | GPS        | GPS_CLK   |           |           |           | EINT0  |        |            | 
|          | PG1      |           | GPS        | GPS_SIGN  |           |           |           | EINT1  |        |            | 
|          | PG2      |           | GPS        | GPS_MAG   |           |           |           | EINT2  |        | USB0-IDDET | 
|          | PG3      |           | UART1      | SDC1_CMD  | MS_BS     | UART1_TX  |           | EINT3  |        |            | 
|          | PG4      |           | UART1      | SDC1_CLK  | MS_CLK    | UART1_RX  |           | EINT4  |        |            | 
|          | PG5      |           | UART1      | SDC1_D0   | MS_D0     | UART1_CTS |           | EINT5  |        |            | 
|          | PG6      |           | UART1      | SDC1_D1   | MS_D1     | UART1_RTS | UART2_RTS | EINT6  |        |            | 
|          | PG7      |           | UART2      | SDC1_D2   | MS_D2     |           | UART2_TX  | EINT7  |        |            | 
|          | PG8      |           | UART2      | SDC1_D3   | MS_D3     |           | UART2_RX  | EINT8  |        |            | 
|          | PG9      |           | SPI1       | SPI1_CS0  | UART3_TX  |           |           | EINT9  |        |            | 
|          | PG10     |           | SPI1       | SPI1_CLK  | UART3_RX  |           |           | EINT10 |        |            | 
|          | PG11     |           | SPI1       | SPI1_MOSI | UART3_CTS |           |           | EINT11 |        |            | 
|          | PG12     |           | SPI1       | SPI1_MISO | UART3_RTS |           |           | EINT12 |        |            | 
|          | PG13     | PWM1      | SPI1       | SPI1_CS1  | PWM1      |           | UART2_CTS | EINT13 |        |            | 
| TVOUT    | TVOUT    |           | TVOUT      |           |           |           |           |        |        |            | 
| USB      | UDM0     | USB0      |            |           |           |           |           |        |        |            | 
|          | UDP0     | USB0      |            |           |           |           |           |        |        |            | 
|          | UDM1     | USB1      |            |           |           |           |           |        |        |            | 
|          | UDP1     | USB1      |            |           |           |           |           |        |        |            | 
|          | VCC_USB  |           |            |           |           |           |           |        |        |            | 
| TP       | TPX1     |           | TP         |           |           |           |           |        |        |            | 
|          | TPX2     |           | TP         |           |           |           |           |        |        |            | 
|          | TPY1     |           | TP         |           |           |           |           |        |        |            | 
|          | TPY2     |           | TP         |           |           |           |           |        |        |            | 
|          | LINEINL  |           | LINEIN     |           |           |           |           |        |        |            | 
|          | LINEINR  |           | LINEIN     |           |           |           |           |        |        |            | 
|          | MIC1OUTP |           |            |           |           |           |           |        |        |            | 
|          | MIC1OUTN |           |            |           |           |           |           |        |        |            | 
|          | VMIC     |           |            |           |           |           |           |        |        |            | 
|          | MICIN2   | MICIN2    |            |           |           |           |           |        |        |            | 
|          | MICIN1   | MICIN1    |            |           |           |           |           |        |        |            | 
|          | VRA1     |           |            |           |           |           |           |        |        |            | 
|          | VRA2     |           |            |           |           |           |           |        |        |            | 
|          | AVCC     |           |            |           |           |           |           |        |        |            | 
|          | VRP      |           |            |           |           |           |           |        |        |            | 
|          | AGND     |           |            |           |           |           |           |        |        |            | 
|          | HPR      | AUDIO-OUT |            |           |           |           |           |        |        |            | 
|          | HPCOM    | AUDIO-OUT |            |           |           |           |           |        |        |            | 
|          | HPCOMFB  |           |            |           |           |           |           |        |        |            | 
|          | VCC_HP   |           |            |           |           |           |           |        |        |            | 
|          | HPBP     |           |            |           |           |           |           |        |        |            | 
|          | HPL      | AUDIO-OUT |            |           |           |           |           |        |        |            | 
| LRADC    | LRADC0   | LRADC0    |            |           |           |           |           |        |        |            | 
|          | LRADC1   |           |            |           |           |           |           |        |        |            | 
