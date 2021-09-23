org 0x0000

  ori $1, $0, 0x0011 #num1
  ori $2, $0, 0x0011 #num2

  ori $3, $0, 0x0013 #num1
  ori $4, $0, 0x0014 #num2

#add $1, $2 ,$3
j jump_task

jump_task:
sw $3, 100($0)
jal jal_task

sw $2, 108($0)
halt

jal_task:
sw $4, 104($0)
jr $31





