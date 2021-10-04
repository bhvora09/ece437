org 0x0000

  ori $1, $0, 0x0011 #num1
  ori $2, $0, 0x0011 #num2

  ori $3, $0, 0x0013 #num1
  ori $4, $0, 0x0014 #num2

beq $1, $2 , beq_task


beq_task:
sw $3, 100($0)
bne $3, $4, bne_task

j HALT1

bne_task:
sw $4, 104($0)


HALT1:halt

