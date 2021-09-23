org 0x0000

  ori $1, $0, 0x0011 #num1
  ori $2, $0, 0x0011 #num2

  ori $3, $0, 0x0013 #num1
  ori $4, $0, 0x0014 #num2

sw $2, 108($0)
halt

sw $4, 104($0)
