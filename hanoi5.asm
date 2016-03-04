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
		# assign n to a temp register t3
		la $t3, ($s0)
		jal load
		lw $ra, 0($sp)
		
load:
		la $ra, 0($sp)
		subi $sp,$sp,4 	# sp = sp - (1 word)
		sw  $t3, ($sp)
		addi $t3, $t3, -1	# n = n - 1
		bne $t3, $zero, load	# if n =/= 0, loop back to 'load'
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
		