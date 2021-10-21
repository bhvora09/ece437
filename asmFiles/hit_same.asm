org 0x000

ori $1, $0, 0xF0
ori $2, $0, 1

ori $3, $0, 2

loop:
    lw $4, 0($1)
    sub $3, $3, $2
    bne $3, $0, loop
    
sw $4, 0($1)
halt
