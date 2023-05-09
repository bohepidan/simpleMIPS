addi  $8,  $0, -1
ori  $9,  $0, 0
ori  $10, $0, 1

ori  $16, $0, 0

beq  $8,  $9, lb1
addi $16, $16, 1	# s0 = 1
lb1:
beq  $8,  $8, lb2
addi $16, $16, 2	
lb2:

bne  $8,  $9, lb3
addi $16, $16, 1	
lb3:
bne  $8,  $8, lb4
addi $16, $16, 2	# s0 = 3
lb4:

bgtz $8,  lb5
addi $16, $16, 1	#s0 = 4
lb5:
bgtz $9,  lb6
addi $16, $16, 2	# s0 = 6
lb6:
bgtz $10,  lb7
addi $16, $16, 3	
lb7:			# s0 = 6

bgez $8, lb8
addi $16, $16, 1	# s0 = 7
lb8:
bgez $9, lb9
addi $16, $16, 1	
lb9:			# s0 = 7
bgez $10, lb10
addi $16, $16, 1	
lb10:			# s0 = 7

bltz $8, lb11
addi $16, $16, 1	# s0 = 7
lb11:
bltz $9, lb12
addi $16, $16, 2	# s0 = 9
lb12:
bltz $10, lb13
addi $16, $16, 3	# s0 = 12
lb13:

blez $8, lb14
addi $16, $16, 1	# s0 = 12
lb14:
blez $9, lb15
addi $16, $16, 2	# s0 = 12
lb15:
blez $10, lb16
addi $16, $16, 3	# s0 = 15
lb16: