# ------------------------------------------------------------------
# i to s
# s to s
# ------------------------------------------------------------------
    org   0x0000
        ori $2, $0, 0x1FC0
        lw $3, 0($2)
        #lw $3, 0($2)
        halt

    org   0x0200
        ori $2, $0, 0x1FC0
        lw $3, 0($2)
        #lw $3, 0($2)
        halt

    #org 0x80
        #cfw 0xC007

    org 0x1FC0
        cfw 0xBEEF

