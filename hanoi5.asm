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
# input received:
# $s0: # disks
# $s1: # poles
		addi $t2, $zero, 4 	# size of each word
		mult $t2, $s0 		
		mflo $t2 			# size of each stack ( 1 word * number of disks )
		add $a2, $t2, $sp		# spare stack @ $sp + (4)(disks)
		# final stack start address @ $sp + 2* (4)(disks) 
		add $a3, $a2, $t2	 
		move $s2, $t2
		# assign n to a temp register t3
		la $t3, ($s0)
		jal load
		lw $ra, 0($sp)
# sp: first stack
# a2: spare stack
# a3: final stack
load:
		la $ra, 0($sp) # $sp : start of the first stack
		subi $sp,$sp,4 	# sp = sp - (1 word)
		sw  $t3, ($sp)
		addi $t3, $t3, -1	# n = n - 1
		bne $t3, $zero, load	# if n =/= 0, loop back to 'load'
		j move1
move1:
		lw $t4, ($sp) # t4 contains value 1 (to be moved)
		addu $sp, $sp, 4
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
		
