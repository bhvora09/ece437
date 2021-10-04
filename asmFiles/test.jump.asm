
  #------------------------------------------------------------------
  # Tests: jumps (J, JAL JR)
  #------------------------------------------------------------------

start:
  org   0x0000
  J     test1 
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
  JAL   cont //not not equal
  lui   $7,0xBBFF
  nop
  nop
  sw    $7, 8($2)
  halt
cont:
  lui   $7,0xBEEF
  nop
  nop
  sw    $7, 12($2)
  JR    $31
  halt
