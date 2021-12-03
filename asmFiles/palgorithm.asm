#REGISTERS
#at $1 at
#v $2-3 function returns
#a $4-7 function args
#t $8-15 temps
#s $16-23 saved temps (callee preserved)
#t $24-25 temps
#k $26-27 kernel
#gp $28 gp (callee preserved)
#sp $29 sp (callee preserved)
#fp $30 fp (callee preserved)
#ra $31 return address

#----------------------------------------------------------
# First Processor PRODUCER
#----------------------------------------------------------
  org 0x0000
  ori   $sp, $zero, 0x3ffc  # stack
  jal   mainp0              # go to program
  halt

  mainp0:
    push $ra
    ori $t9, $zero, 256 #number of data- (256)
    ori $t8, $zero, 1 #to subtract 256
    ori $s0, $zero, 0x7 #seed number
  getNum:
    or $a0, $s0, $zero #crc input  
    jal crc32
    or $s0, $zero, $v0
    or $a1, $zero, $v0
    
    ori $a0, $zero, lck
    jal lock
  
    #critical code segment
    ori $a0, $zero, stptr
    jal push2
    ori $26, $zero, 0xBEEF
    #critical code sement

    ori $a0, $zero, lck
    jal unlock

    sub $t9, $t9, $t8
    bne $zero, $t9, getNum
      
    pop $ra
    jr $ra
    
  lck:
    cfw 0x0000


#----------------------------------------------------------
# LOCK and UNLOCK
#----------------------------------------------------------
# pass in an address to lock function in argument register 0
# returns when lock is available
  lock:
  aquire:
    ll    $t0, 0($a0)         # load lock location
    bne   $t0, $0, aquire     # wait on lock to be open
    addiu $t0, $t0, 1
    sc    $t0, 0($a0)
    beq   $t0, $0, lock       # if sc failed retry
    jr    $ra


  # pass in an address to unlock function in argument register 0
  # returns when lock is free
  unlock:
    sw    $0, 0($a0)
    jr    $ra

#----------------------------------------------------------
# Second Processor CONSUMER
#----------------------------------------------------------
  org 0x2000
    ori   $sp, $zero, 0x7ffc  # stack
    jal   mainp1              # go to program
    halt

    mainp1:
      push $ra
      ori $s0, $zero, 256 #number of data (256)
      ori $s1, $zero, 1 #to subtract 256
      ori $s4, $zero, 0xFFFF #running min
      or $s5, $zero, $zero #running max
      or $s3, $zero, $zero #running sum
    
    loop:
      jal empty

      ori $a0, $zero, lck
      jal lock

      ori $a0, $zero, stptr #stackptr addr
      jal pop2
      ori $27, $zero, 0xABCD

      ori $a0, $zero, lck
      jal unlock

      or $t9, $zero, $v0
      andi $t9, $t9, 0xFFFF
      
      or $a0, $zero, $t9
      or $a1, $zero, $s4
      jal min
      or $s4, $zero, $v0 #running min
      
      or $a0, $zero, $t9
      or $a1, $zero, $s5
      jal max
      or $s5, $zero, $v0 #running max
      
      add $s3, $s3, $t9 #running sum
      
      sub $s0, $s0, $s1
      bne $s0, $zero, loop

#------------------------------------------------------
# AVERAGE
#------------------------------------------------------
  average:
    ori $t8, $zero, 8  #shift division binary 256 - (256)
    srlv $s3, $t8, $s3
    ori $t8, $zero, acc_avg
    sw $s3, 0($t8)

#storing max and min
    ori $t8, $zero, acc_min
    sw $s4, 0($t8)

    ori $t8, $zero, acc_max
    sw $s5, 0($t8)

    pop $ra
    jr $ra

#------------------------------------------------------
# MAX
#------------------------------------------------------
    #-max (a0=a,a1=b) returns v0=max(a,b)--------------
    max:
      push  $ra
      push  $a0
      push  $a1
      or    $v0, $0, $a0
      slt   $t0, $a0, $a1
      beq   $t0, $0, maxrtn
      or    $v0, $0, $a1
    maxrtn:
      pop   $a1
      pop   $a0
      pop   $ra
      jr    $ra

#------------------------------------------------------
# MIN
#------------------------------------------------------
    #-min (a0=a,a1=b) returns v0=min(a,b)--------------
    min:
      push  $ra
      push  $a0
      push  $a1
      or    $v0, $0, $a0
      slt   $t0, $a1, $a0
      beq   $t0, $0, minrtn
      or    $v0, $0, $a1
    minrtn:
      pop   $a1
      pop   $a0
      pop   $ra
      jr    $ra

#------------------------------------------------------
# PUSH takes in (stack address, value to push) (a0, a1)
#------------------------------------------------------
  push2:
    lw $t0, 0($a0) #load stack pointer
    ori $t1, $zero, stoff
    lw $t2, 0($t1)
    sub $t0, $t0, $t2
    sw $a1, 0($t0) #store value onto stack
    ori $t3, $zero, 4 
    add $t2, $t2, $t3 #increment stack index
    sw $t2, 0($t1) #store stack pointer
    jr $ra


#------------------------------------------------------
# POP takes in (($a0)stack address)  $v0 = return vlaue
#------------------------------------------------------
  pop2:
    push $ra
    lw $t0, 0($a0) #load stack pointer
    ori $t1, $zero, stoff
    lw $t2, 0($t1) #offset value
    ori $t3, $zero, 4
    sub $t2, $t2, $t3 #get stack[offset]
    sub $t0, $t0, $t2
    lw $v0, 0($t0) #load value from stack
    sw $zero, 0($t0) #store 0 to stack addr
    sw $t2, 0($t1) #store stack pointer
    pop $ra
    jr $ra

#---------------------------------------------------
# empty checks if the stack is empty
#---------------------------------------------------
  empty:
    ori $t0, $zero, stoff
    lw $t1, 0($t0)
    beq $t1, $zero, empty #loop till stack off changes
    jr $ra

#----------------------------------------------------------
# CRC
# USAGE random0 = crc(seed), random1 = crc(random0)
#       randomN = crc(randomN-1)
#------------------------------------------------------
    # $v0 = crc32($a0)
    crc32:
      lui $t1, 0x04C1
      ori $t1, $t1, 0x1DB7
      or $t2, $0, $0
      ori $t3, $0, 32

    l1:
      slt $t4, $t2, $t3
      beq $t4, $zero, l2

      ori $t5, $0, 31
      srlv $t4, $t5, $a0
      ori $t5, $0, 1
      sllv $a0, $t5, $a0
      beq $t4, $0, l3
      xor $a0, $a0, $t1
    l3:
      addiu $t2, $t2, 1
      j l1
    l2:
      or $v0, $a0, $0
      jr $ra
    

stptr:
  cfw 0xbffc

stoff:
 cfw 0x0

org 0x6000
acc_avg:
  cfw 0x0
acc_min:
    cfw 0xFFFF
acc_max:
  cfw 0x0
