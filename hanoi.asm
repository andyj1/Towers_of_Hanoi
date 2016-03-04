.data
title: 	.asciiz "Tower of Hanoi\n"
disk:	.asciiz "Disks: \n"
pole:	.asciiz "Pegs: \n"
finish:	.asciiz "Finished. It took "
times:	.asciiz "times."
errinput:	.asciiz "Invalid inputs"
.text
	.globl main
main:
		# title
		la $v0, 4
		la $a0, title
		syscall
		# disk
		la $v0, 4
		la $a0, disk
		syscall	
		# input: disks
		li $v0, 5
		syscall
		move $t0, $v0
		move $s0, $t0
		# pole
		la $v0, 4
		la $a0, pole
		syscall
		# input: pole
		li $v0, 5
		syscall
		move $t1, $v0
		move $s1, $t1
		
		slti $t7,$s0, 3		# disks have to be greater than 3
		slti $t7, $s1, 3	# poles have to be greater than 3
		beq $t7, 1, exit	# if disks or poles are less than 3, exit
# input received:
# $s0: # disks
# $s1: # poles
		add $a1, $sp, $zero
		addi $t2, $zero, 4 	# size of each word
		mult $t2, $s0 		
		mflo $t2 			# size of each stack ( 1 word * number of disks )
		add $a2, $t2, $a1		# spare stack @ $sp + (4)(disks)
		# final stack start address @ $sp + 2* (4)(disks) 
		add $a3, $a2, $t2	 
		move $s2, $t2
		# assign n to a temp register t3
		la $t3, ($s0)
		jal load
		lw $ra, 0($sp)
# a1: first stack
# a2: spare stack
# a3: final stack
load:
		la $ra, 0($sp) # $sp : start of the first stack
		subi $sp,$sp,4 	# sp = sp - (1 word)
		sw  $t3, ($sp)
		addi $t3, $t3, -1	# n = n - 1
		bne $t3, $zero, load	# if n =/= 0, loop back to 'load'
		add $t4, $zero, $a1	#t4 is the temporary source
		add $t5, $zero, $a2	#t5 is the temporary spare
		add $t6, $zero, $a3	#t6 is temporary destination
		j moveTower		#go to movetower
	
moveTower:				#move tower from source peg to destination peg
		slti $t3, $t0, 2	#test if disks == 0
		beq $t3,$zero,L1 	#if disks are not zero, go to L1
		#I am still working onthe part below
					#if 
		
L1:		
		add $t7, $zero, $t5	#save t7 into t5
		add $t5, $zero, $t6	#set temporary spare as temporary destination
		add $t6, $zero, $t7	#set temporary destination as temporary spare
		addi $t0, $t0, -1	#decrease t0
		jal moveTower		#recursion call
		
				
		
		j exit
exit:
		# terminate
		li $v0, 10
		syscall

		# testing for the data output
		# addi $sp, $sp,4	
		# li $v0, 4 
		# sw $a0, ($sp)
		# syscall
		