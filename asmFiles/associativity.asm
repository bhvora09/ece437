org 0x0000

ori $1, $0, 0x3F0

ori $2, $0, 0x2F0

ori $3, $0, 0x1F0

lw $6, 0($1)
lw $7, 0($2)
lw $7, 0($3)


halt

org   0x0200
halt

org 0x1F0
cfw 0xC007

org 0x2F0
cfw 0xABCD

org 0x3F0
cfw 0xBEEF

