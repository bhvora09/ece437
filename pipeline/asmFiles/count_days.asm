#---------------------------------------
# sample asm file for tutorial
#---------------------------------------

# set the address where you want this
# code segment
  org 0x0000

  ori $29, $0, 0xFFFC   #initialise stack pointer at 0xfffc
  ori $1, $0, 5 #current date
  ori $2, $0, 9 #current month
  ori $3, $0, 2021 #current year
  j count_days
 
  
#--------------------------------------------------------------------
count_days:
addi $2, $2, -1
addi $3, $3, -2000

ori $4, $0, 30  #30 const
ori $5, $0, 365 #365 const

#result= day + 30* $5 + 365 *$3
push $4 #30
push $2 #month -1
jal Multiplier
  
pop $6  #month-1 * 30

push $5 #365
push $3 #year-2000
jal Multiplier

pop $7  #365* year-2000

add $1, $1, $6
add $1, $1, $7
push $1
halt

#multiplying sub routine
#-------------------------------------------------------
Multiplier:
pop $10  #month-1, year-2000
pop $11  #30, 365
  
  bne $10,  $0, IF2   #if A!=0
  ori $28, $0, 0x0000
  j EXIT

  IF2:
  bne $11, $0, IF3  #if B!=0
  ori $28, $0, 0x0000
  j EXIT

  IF3:
  ori $12, $0, 0x0001  #temp storage for numer 1
  bne $10, $12, MULT  #if A!= 1
  ori $28, $11, 0x0000
  j EXIT

  MULT:
  ori $13, $0, 0x0001   #counter b=1
  addi $28, $10, 0x0000      #temp register gets value of num1
  WHILE: 
  beq $13, $11, EXIT      #if b== num2 then exit i.e. $ b==1 and returns num1
  LOOP: 
  add $28, $28,$10    #val = val +num1
  addi  $13, $13, 0x0001     #update counter
  j WHILE
  j EXIT

  EXIT:
  push $28
  jr $ra
#---------------------------------------------------------------------------------




