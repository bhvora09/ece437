#---------------------------------------
# asm file for multiplying 2 numbers
#---------------------------------------

# set the address where you want this
# code segment
  org 0x0000

  ori $29, $0, 0xFFFC   #initialise stack pointer at 0xfffc
  ori $1, $0, 0x0011 #num1
  ori $2, $0, 0x0012 #num2

  push $1
  push $2

  
  j Multiplier
  Multiplier:
  pop $3  #num2
  pop $4  #num1
  
  bne $3,  $0, IF2   #if A!=0
  ori $28, $0, 0x0000
  j EXIT

  IF2:
  bne $4, $0, IF3  #if B!=0
  ori $28, $0, 0x0000
  j EXIT

  IF3:
  ori $6, $0, 0x0001  #temp storage for numer 1
  bne $3, $6, MULT  #if A!= 1
  ori $28, $4, 0x0000
  j EXIT

  MULT:
  ori $5, $0, 0x0001   #counter b=1
  addi $28, $3, 0x0000  #temp register gets value of num2
  WHILE: 
  beq $5, $4, EXIT      #if b== num1 then exit i.e. $ b==1 and returns num1
  LOOP: 
  add $28, $28,$3     #val = val +num1
  addi  $5, $5, 0x0001     #update counter
  j WHILE
  j EXIT

  EXIT:
  push $28

  halt
