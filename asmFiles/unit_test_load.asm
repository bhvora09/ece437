
  #------------------------------------------------------------------
  # Tests lui lw sw
  #------------------------------------------------------------------

  org   0x0000
  ori   $1,$zero,0xF0
  ori   $2,$zero,0x80
  lui   $7,0xdead
  ori   $7,$7,0xbeef
  lw    $3,0($1)
  lw    $4,4($1)
  lw    $5,8($1)
  add  $6, $4,$5

  push $6

  halt
