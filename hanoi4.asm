#########################################################################
#   System call constants
# SYS_PRINT_INT       =   1
# SYS_PRINT_FLOAT     =   2
# SYS_PRINT_DOUBLE    =   3
# SYS_PRINT_STRING    =   4
# SYS_READ_INT        =   5
# SYS_READ_FLOAT      =   6
# SYS_READ_DOUBLE     =   7
# SYS_READ_STRING     =   8
# SYS_SBRK            =   9
# SYS_EXIT            =   10
# SYS_PRINT_CHAR      =   11
# SYS_READ_CHAR       =   12
#########################################################################

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
		# stack pointer declaration
		move $sp,$zero
		la $a0, ($sp)
# input received:
# $s0: # disks
# $s1: # poles

# extra n-poles: spare pegs between the start and final pole	
		addi $t1, $zero, 4 	# size of each word
		mult $t1, $s0 		# size of each stack
		mflo $t2 
		sub $a2, $t2, $sp		# locate the address of next stack @ sp + (4)(disks)
# final stack address
		sub $a3, $a2, $t2	 
# a0 	: # of disks entered
# a1 = sp: first stack
# a2		: extra n-pole stack
# a3 	: final stack
		blt $s0, 2, error
		blt $s1, 3, error
		bge $s0, 3, move1	
		
move1:
		subi $t4, $s0, 1
		sub $t4, $s0, $t4  
		j move2
move2:
		subi $t5, $s0, 1

		 j exit
error:
		li $v0, 4
		la $a0, errinput
		syscall
exit:
		li $v0, 10
		la $a0, finish
		syscall		

#######################################
# allocation, assignment of addresses finished
#######################################

		

