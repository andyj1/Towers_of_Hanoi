# School: The Cooper Union
# Course: ECE151A Spring 2016
# Assignment: Towers of Hanoi in MIPS 
# Group members: Andy Jeong, Brenda So, Gordon Macshane
# Date: 3/7/2016
#
# Note for this specific program:
# 	The input of disks should be == 3 (integer)
# 	The input of pegs should be == 3 (integer)
.data
title: 	.asciiz "Tower of Hanoi\n"					#Program title
disk:	.asciiz "Disks: \n"								#prints out the input value of disks
pole:	.asciiz "Poles: \n"								#prints out the input value of poles
finish:	.asciiz "Finished. Final destination pole has: \n"	#prints out the final pole in order in each line
newline: .asciiz "\n"									#new line character
.text
	.globl main
main:
		la $v0, 4		# title print out
		la $a0, title
		syscall
		la $v0, 4		# disk input prompt
		la $a0, disk
		syscall	
		li $v0, 5		# takes in input: disks
		syscall
		move $t0, $v0
		move $s0, $t0
		la $v0, 4		# pole input prompt
		la $a0, pole
		syscall
		li $v0, 5		# takes in input: pole 
		syscall
		move $t1, $v0
		move $s1, $t1
#########################################
# input received:   $s0:  # of disks  $s1: # of poles
#########################################
		add $a1, $sp, $zero 	# $a1 = $sp
		addi $t2, $zero, 4 	# size of each word, 4, = $t2
		mult $t2, $s0 		# 4 * number of disks operation
		mflo $t2 			# size of each stack ( = 1 word * number of disks )
		add $a2, $t2, $a1		# spare stack @ $sp + (4)(disks)
		add $a3, $a2, $t2	 	# final stack start address @ $sp + 2* (4)(disks) 
		move $s2, $t2	  # size of each stack stored in $s2
		la $t3, ($s0)		#  number of disks = $t3 (temporary register)
		j load
		lw $ra, 0($sp)
#########################################
# addressses for each stack
# a1: first stack
# a2: spare stack
# a3: final stack
#########################################
load:
		la $ra, 0($sp) 			# $sp : start of the first stack
		subi $sp,$sp,4 			# sp = sp - (1 word)
		sw  $t3, ($sp)			# store the number of disks into 0($sp)
		addi $t3, $t3, -1		# decrement the number of disks (n)
		bne $t3, $zero, load	# if n != 0, loop back to 'load'
		sub $a1, $a1, $s2		#go to second stack address (at its start)
		add $s4, $zero, $a1	#s4: temporary source address
		add $s5, $zero, $a2	#s5: temporary spare address
		add $s6, $zero, $a3	#s6: temporary destination address
		add $s3, $zero, $a3	#s3: temporary destination address
		sw $a1, 0($s3)			#store the content of first address of first stack to the first address of destination stack 
		j move1					#jump
#########################################	
# Stacks	
# s4: source
# s3, s6: destination
# s5: spare
#########################################
move1:				#move tower from source peg to destination peg
		sw $ra, 0($s3)	# store addresses of each stack to the last stack addresses (so one could debug better)
		sw $s4, 4($s3)
		sw $s5, 8($s3)
		sw $s6, 12($s3)
		addi $s3, $s3, 16		#move s3 down by 2 items
		slti $t3, $t0, 2		#test if disks == 0
		beq $t3,$zero,loop		#if disks are not zero, go to L1
		add $sp, $zero, $s4		#where disk moving happens
		lw $t7, 0($sp)			#pop first disk from current location
		sw $zero, 0($sp)		#after popping, set popped value to zero
		addi $sp, $sp, 4		#pop 1 item from stack
		add $s4, $zero, $sp		#reset temporary 
		add $sp, $zero, $s6		#go to temporary final destination
		subi $sp, $sp, 4
		sw $s4, -12($s3)		#save newest value of s4
		sw $t7, 0($sp)			#save number into temporary final destination
		subi $s6, $s6, 4		#move pointer up
		sw $s6, -4($s3)			#save the newest value of s6
		jr $ra					#go back to loop
loop:		
		add $t7, $zero, $s5		#save t7 into t5
		add $s5, $zero, $s6		#set temporary spare as temporary destination
		add $s6, $zero, $t7		#set temporary destination as temporary spare
		addi $t0, $t0, -1		#decrease t0
		jal move1				#recursion call
		#for moving disks
		addi $t0, $t0, 1		#move t0 back up
		subi $s3, $s3, 12		#pop 3 items up
		lw $s4, 0($s3)
		lw $s5, 8($s3)			#load destination back
		lw $s6, 4($s3)			#load spare back
		subi $s3, $s3, 16
		add $sp, $zero, $s4		#where disk moving is supposed to happen
		lw $t7, 0($sp)			#pop first disk from current location
		sw $zero, 0($sp)		#after popping, set popped value to zero
		addi $sp, $sp, 4		#pop 1 item from stack
		add $s4, $zero, $sp		#reset temporary 
		add $sp, $zero, $s6		#go to temporary final destination
		subi $sp, $sp, 4
		sw $s4, -12($s3)
		sw $t7, 0($sp)			#save number into temporary final destination
		subi $s6, $s6, 4		#move pointer up
		sw $s4, 0($s3)			#save temp source to memory
		sw $s5, 4($s3)			#save temp spare to memory
		sw $s6, 8($s3)			#save temp destination to memory
		addi $s3, $s3, 12		#move s3 down by 2 items
		#end of moving disks
		add $t7, $zero, $s4
		add $s4, $zero, $s5		#set temporary source as temporary spare
		add $s5, $zero, $t7		#set temporary spare as temporary source
		subi $t0, $t0, 1
		jal move1				#go to moveTower2
		addi $t0, $t0, 1	
		add $ra, $zero, $sp 
		la $s7, ($s5)			# address of 3 retrieved from $s5
		lw $t7, 0($s7)  		# t7 =  3
		add $t8, $zero, $s0
		lw $ra, 0($sp)
		beq $t8, $t7, move2
		beq $t0, $s1, exit
		lw $ra, -16($s3)
		jr $ra
move2:
		add $t0, $s1, -1
		mult $t0, $s1
		mflo $t6			
		addi $t4, $zero, 4
		mult $t6, $t4
		mflo $t6
		add $s7, $s7, $t6
		sw $t7, 0($s7)
		sw $zero, 0($s5)	
		la $sp, 0($s6)		# address of 1 retrieved from $s6
		lw $t5, 0($sp)
		sw $t5, 0($s5)
		sw $zero, 0($s6)
		addi $s6, $s6, 4
		la $sp, 0($s6)		# address of 2 retrieved from $s6+4
		lw $t5, 0($sp)
		addi $s7, $s7, -4
		sw $t5, 0($s7)
		sw $zero, 0($s6)
		add $t6, $zero, $t5
		la $sp, 0($s5)		# address of 1 retrieved from $s5
		lw $t5, 0($sp)
		addi $s7, $s7, -4
		sw $t5, 0($s7)
		sw $zero, 0($s5)
		add $t5, $zero, $t5
		move $s4, $t5
		move $s5, $t6
		move $s6, $t7
		#t5: n (Number of disks)
		#t6: n-1
		#t7: n-2	
exit:	
		#finish call
		li $v0, 4
		la $a0, finish
		syscall

		li $v0, 1
		la $a0, ($s4)
		syscall
		
		li $v0, 4
		la $a0, newline
		syscall
		
		li $v0, 1
		la $a0, ($s5)
		syscall
		
		li $v0, 4
		la $a0, newline
		syscall
		
		li $v0, 1
		la $a0, ($s6)
		syscall
		
		# return 1
		#li $v0, 1
		#la $a0, ($v0)
		#syscall
		
		# terminate
		li $v0, 10
		syscall

		# testing for the data output
		# addi $sp, $sp,4	
		# li $v0, 4 
		# sw $a0, ($sp)
		# syscall
		
