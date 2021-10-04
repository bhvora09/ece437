
  #------------------------------------------------------------------
  # Tests: breaks (BNE and BEQ both taken and not taken)
  #------------------------------------------------------------------

start:
  org   0x0000
  ori   $2,$zero,0xF0
  ori   $3,$zero,0x80
  nop
  nop
  bne   $2, $3, test1 //not equal it runs
  lui   $7,0xdead //runs if it is equal
  nop
  nop
  sw    $7, 0($2)
  halt

test1:
  lui   $7,0xFF
  nop
  nop
  sw    $7, 4($2)
  ori   $4,$zero,0xc4
  ori   $5,$zero,0xc4
  nop
  nop
  bne   $4, $5, err //not not equal
  lui   $7,0xFF
  nop
  nop
  sw    $7, 8($2)
  beq   $4, $5, test2 //equal
  //not equal continues to err
err:
  lui   $7,0xdead
  sw    $7, 0($2)
  halt

test2:
  lui   $7,0xFF
  nop
  nop
  sw    $7, 12($2)
  ori   $4,$zero,0x89
  ori   $5,$zero,0xc4
  nop
  nop
  beq   $4, $5, err
  lui   $7,0xFF
  nop
  nop
  sw    $7, 12($2)
  halt
