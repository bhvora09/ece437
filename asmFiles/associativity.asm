org 0x0000

ori $1, $0, 0x3F8
ori $2, $0, 0x2F8

ori $3, $0, 0x1F8

lw $4, 0($1)
lw $5, 0($2)
lw $6, 0($1)
lw $7, 0($2)
lw $7, 0($3)


halt
