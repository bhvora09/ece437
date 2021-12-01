#------------------------------------------------------------------
# Test llsc1
# Note: SW/SC should invalidate the link register if there is an
#       address match in the opposite core or in the same core.
#------------------------------------------------------------------

  org   0x0000
  ori   $1, $zero, 0x1FC0
  ori   $2, $zero, 0x80

  lw    $3, 0($2)       #load 80 -> $3
  addiu   $3, $3, 0x01  #$3 <-81
  sw    $3, 0($2)

  ll    $3, 0($2) #ll at 0x80
  addiu   $3, $3, 0x01
  sc    $3, 0($2) #sc at 0x80
  sc    $3, 0($2) #sc to fail 

  ll    $3, 8($2) #ll at 0x88
  addiu   $3, $3, 0x01 
  sw    $3, 8($2) #sw at 0x88 
  sc    $3, 8($2) #sc at 0x88
  sw    $3, 8($2) #normal store at #0x88

  halt      # that's all

  org   0x0200
  ori   $1, $zero, 0x1FC0
  ori   $2, $zero, 0x90

  lw    $3, 0($2)
  addiu   $3, $3, 0x01
  sw    $3, 0($2)

  ll    $3, 0($2) #ll at 0x90
  addiu   $3, $3, 0x01
  sc    $3, 0($2) #sc at 0x90
  sc    $3, 0($2) #sc at 0x90

  ll    $3, 8($2) #ll at 0x98
  addiu   $3, $3, 0x01
  sw    $3, 8($2) #sw at 0x98
  sc    $3, 8($2)
  sw    $3, 8($2)

  halt      # that's all


