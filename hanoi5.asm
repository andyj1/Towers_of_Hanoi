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
		bne $s0, $zero, load
load:
		addi $ra, $sp, 4
		la $t3,($s0)
		la  $sp, ($t3)
		addi $t3, $t3, -1
		bne $t3, $zero, load
		
		j exit
exit:
		li $v0, 10
		