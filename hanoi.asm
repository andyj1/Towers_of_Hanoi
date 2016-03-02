.data
	inputN: .asciiz "Please enter the number of disks: \t"
	moving:	.asciiz " Moving: "
	source:	.asciiz " from  "	
	destination:	.asciiz "to "	
	finished:		.asciiz "Finished.\t- End of Tower of Hanoi -\n"
	space: .asciiz "\n"
	
.text
	.globl main
main:
	# add $fp, $zero, $sp 	#initialize frame pointer from stack pointer
	la $v0, 4
	la $a0, inputN		# prompt for input
	syscall
	
	li $v0, 5
	syscall
	
	add  $a0, $zero, $v0	# store input N into an address
	addi $a1,  $zero, 1
	addi $a2,  $zero, 2
	addi $a3,  $zero, 3
	jal hanoiTower
	
Exit:
	# calls finished string to be printed
	li $v0, 4 
	la $a0, finished
	syscall
	# terminates
	li $v0, 10
	syscall
		
hanoiTower:
	# need to allocate memory for return addr, varying N, poles (addr, storage for return)
	subu $sp, $sp, 4
	sw $ra,0($sp)	# set return address
	
	sw $s0, 0($sp)	# storage reg 1
	subu $sp, $sp, 4
	sw $s1,0($sp)	# storage reg 2
	subu $sp, $sp, 4
	sw $s2, 0($sp)	# storage reg 3
	
	beq $a0, $zero, zeroCase
	subu $sp, $sp, 4
	sw $a0, 0($sp)	# N
	
	subu $sp, $sp, 4
	sw $a1, 0($sp)	# pole 1
	subu $sp, $sp, 4
	sw $a2, 0($sp)	# pole 2
	subu  $sp ,$sp, 4
	sw $a3, 0($sp)	# pole 3
	subu $sp, $sp, 4
		
	subi $a0, $a0, 1	# update N = N -1
	
			
	# swap pole 2 and 3
	add $t0, $zero, $a2
	add $a2, $zero, $a3
	add $a3, $zero, $t0

	jal hanoiTower	# loop back
	
	# swap pole 1 and 3
	# add $t1, $zero, $a1
	# add $a1, $zero, $a3
	# add $a3, $zero, $t1
	
	subi $a0, $s3, 1		
	add $a1, $zero, $s0
	add $a2, $zero, $s1
	add $a3, $zero, $s2
	jal hanoiTower
	
	# pop the addresses using stack pointer
	addi $sp, $sp, 4
	lw $s0, 0($sp)	# pole 3
	lw $s1, 4($sp)	# pole 2
	lw $s2, 8($sp)	# pole 1
	lw $s3, 12($sp)	# N
	addi $sp, $sp, 12 
	
	# print the results from storage registers
	li $v0, 1
	add $v0, $zero, $s3
	syscall
	bne $a0, $zero, zeroCase
	jal hanoiTower
		
zeroCase:
	
	lw $s3, 0($sp) # N
	lw $s2, 4($sp) # pole 3
	lw $s1, 8($sp) # pole 2
	lw $s0, 12($sp) # pole 1
	lw $ra, 16($sp)
	addi $sp, $sp, 16
	jr $ra
	
	# calls finished string to be printed
	li $v0, 4 
	la $a0, finished
	syscall
	# terminates
	li $v0, 10
	syscall

	
		
			
				
					
						
							
								
									

		
	
	
	
	
	
	
	
	
	
	
	
	
	









	
