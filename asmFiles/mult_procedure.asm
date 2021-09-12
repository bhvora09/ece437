#---------------------------------------
# asm file for multiplying more numbers than 2
#---------------------------------------

# set the address where you want this
# code segment
  org 0x0000

  ori $29, $0, 0xFFFC   #initialise stack pointer at 0xfffc
  ori $1, $0, 0x0002 #num1
  ori $2, $0, 0x0003 #num2
  ori $3, $0, 0x0004
  ori $4, $0, 0x0005

  push $1
  push $2
  push $3
  push $4

  j MULTIPLY_PROCEDURE
#----------------------------------------
MULTIPLY_PROCEDURE:
ori $28, $0, 0xFFF8       #stack at last-1
#ori $5, $0, 0x0001      #consider A i.e. 3
beq $29, $28, EXIT_FINAL    #if stack is empty
pop  $5
pop  $6                 #consider B i.e. 4
jal Multiplier

#NORMAL MULTIPLIER:
#-------------------------------------------
Multiplier:

  bne $5,  $0, IF2   #if A!=0
  ori $5, $0, 0x0000    #return 0
  j EXIT

  IF2:
  bne $6, $0, IF3  #if B!=0
  ori $5, $0, 0x0000    #return 0
  j EXITjal

  IF3:
  ori $7, $0, 0x0001  #temp storage for number 1
  bne $5, $7, MULT  #if A!= 1
  ori $5, $6, 0x0000        #return B
  j EXIT

  MULT:
  ori $8, $0, 0x0001        #counter b=1
  addi $9, $5, 0x0000      #temp register gets value of num1
  WHILE: 
  beq $8, $6, EXIT      #if b== num2 then exit i.e. $ b==1 and returns num1
  LOOP: 
  add $5, $5, $9     #val = val +num1
  addi  $8, $8, 0x0001     #update counter
  j WHILE
  j EXIT

  EXIT:
  push $5
  j MULTIPLY_PROCEDURE
#-------------------------------------------

EXIT_FINAL:
halt
