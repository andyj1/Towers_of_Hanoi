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
		# title print out
		la $v0, 4
		la $a0, title
		syscall
		# disk input prompt
		la $v0, 4
		la $a0, disk
		syscall	
		# takes in input: disks
		li $v0, 5
		syscall
		move $t0, $v0
		move $s0, $t0
		# pole input prompt
		la $v0, 4
		la $a0, pole
		syscall
		# takes in input: pole 
		li $v0, 5
		syscall
		move $t1, $v0
		move $s1, $t1
		# conditions for disks and poles inputs
		slti $t7,$s0, 3		# disks have to be greater than 3
		slti $t7, $s1, 3	# poles have to be greater than 3
		beq $t7, 1, exit	# if disks or poles are less than 3, exit
#########################################
# input received:   $s0:  # of disks  $s1: # of poles
#########################################
		add $a1, $sp, $zero # $a1 = $sp
		addi $t2, $zero, 4 	# size of each word
		mult $t2, $s0 		
		mflo $t2 			# size of each stack ( = 1 word * number of disks )
		add $a2, $t2, $a1		# spare stack @ $sp + (4)(disks)
		add $a3, $a2, $t2	 	# final stack start address @ $sp + 2* (4)(disks) 
		move $s2, $t2  # size of each stack stored in $s2
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
		j moveTower		#go to movetower
moveTower:				#move tower from source peg to destination peg
		beq $t0,$zero,moveDisk 	#if disks are zero, go to decrease
		
		
moveDisk:	lw $t1, 0($sp)		#load word from where sp points to in t1
		addi $ra, $sp, 4	#save the next sp address (where the next disk is) to ra
		add $sp, $sp, $s2	#move stack pointer up by 4N bytes
		sw $t1, 0($sp)		#save the value in t1 to next peg
		jr $ra			#return address of first peg
				
		j exit
exit:	
		# return 1
		li $v0, 1
		la $a0, ($v0)
		syscall
		# terminate
		# li $v0, 10
		# syscall

		# testing for the data output
		# addi $sp, $sp,4	
		# li $v0, 4 
		# sw $a0, ($sp)
		# syscall
		
