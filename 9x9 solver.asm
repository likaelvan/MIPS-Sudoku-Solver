# CS 21 LAB 1 -- S2 AY 2021-2022
# Gorge Lichael Vann N. Vedasto -- 05/01/2022
# 201908952_9.asm -- MP 9x9 Sudoku Solver

.text
main:		
	li $v0, 8  	
	la $a0, r1 	
	li $a1, 10 	
	syscall
	la $a0, r2 
	syscall
	la $a0, r3 
	syscall	
	la $a0, r4 
	syscall
	la $a0, r5 
	syscall
	la $a0, r6 
	syscall
	la $a0, r7
	syscall
	la $a0, r8 
	syscall
	la $a0, r9 
	syscall
	
	jal	solve_sudoku
	
	li $v0, 4 	
	la $a0, r1 
	syscall
	la $a0, newline 
	syscall
	la $a0, r2 
	syscall
	la $a0, newline
	syscall
	la $a0, r3 
	syscall
	la $a0, newline 
	syscall
	la $a0, r4 
	syscall
	la $a0, newline 
	syscall
	la $a0, r5 
	syscall
	la $a0, newline 
	syscall
	la $a0, r6 
	syscall
	la $a0, newline 
	syscall
	la $a0, r7
	syscall
	la $a0, newline 
	syscall
	la $a0, r8
	syscall
	la $a0, newline 
	syscall
	la $a0, r9
	syscall
	
	li	$v0,10		
	syscall

solve_sudoku:
	######preamble######
	subu 	$sp, $sp, 32
	sw 	$ra, 28($sp)
	sw	$s0, 24($sp)
	sw	$s1, 20($sp)
	sw	$s2, 16($sp)
	sw	$s3, 12($sp)
	######preamble######
	la	$s0, r1		
	la	$s2, r9	
	addi	$s2, $s2, 8	
solve_sudoku_loop:
	lb   	$s3, 0($s0)	
	beqz	$s3, solve_sudoku_next 
	subi	$s3, $s3, 48	
	li	$s1, 1		
	beq	$s0, $s2, solve_sudoku_last
	bnez	$s3, solve_sudoku_next
solve_sudoku_zero:
	beq	$s1, 10, solve_sudoku_false
	move 	$a0, $s0	
	move	$a1, $s1	
	jal	check
	beq	$v0, 1, solve_sudoku_fill
solve_sudoku_zero_next:
	addi	$s1, $s1, 1	
	j	solve_sudoku_zero
solve_sudoku_fill:
	addi	$t1, $s1, 48
	sb  	$t1, 0($s0)
	jal	solve_sudoku	
	beq	$v0, 1, solve_sudoku_true
	li	$t1, 48		
	sb 	$t1, 0($s0)	
	j	solve_sudoku_zero_next
solve_sudoku_last:
	bnez	$s3, solve_sudoku_true
	j	solve_sudoku_zero
solve_sudoku_true:
	li	$v0, 1
	j	solve_sudoku_return
solve_sudoku_false:
	li	$v0, 0
	j	solve_sudoku_return
solve_sudoku_next:
	add	$s0, $s0, 1
	j 	solve_sudoku_loop
solve_sudoku_return:
	######end#####
	lw 	$ra, 28($sp)
	lw	$s0, 24($sp)
	lw	$s1, 20($sp)
	lw	$s2, 16($sp)
	lw	$s3, 12($sp)
	addu 	$sp, $sp, 32
	######end######
	jr	$ra
	
check:
	######preamble######
	subu 	$sp, $sp, 32
	sw 	$ra, 28($sp)
	sw	$s0, 24($sp)
	sw	$s1, 20($sp)
	sw	$s2, 16($sp)
	sw	$s3, 12($sp)
	######preamble######
	move	$s0, $a0
	move	$s1, $a1	
	la	$t0, r1		
	sub	$s0, $s0, $t0
	li	$t0, 10
	div 	$s0, $t0
	mflo	$s2		
	mfhi	$s3		
check_row_init:
	mul	$t0, $s2, 10
	la	$s0, r1
	add 	$s0, $s0, $t0
	li	$t0, 0
check_row:
	beq	$t0, 9, check_col_init
	lb	$t1, 0($s0)
	subi	$t1, $t1, 48
	beq	$t1, $s1, check_return_false
	addi	$t0, $t0, 1
	add	$s0, $s0, 1
	j	check_row
check_col_init:
	la	$s0, r1
	add	$s0, $s0, $s3
	li	$t0, 0
check_col:
	beq	$t0, 9, check_3x3_init
	lb	$t1, 0($s0)
	subi	$t1, $t1, 48
	beq	$t1, $s1, check_return_false
	addi	$t0, $t0, 1
	addi	$s0, $s0, 10
	j	check_col
check_3x3_init:
	li	$t0, 3		
	div	$s2, $t0
	mfhi	$t1
	sub	$s2, $s2, $t1	
	mul	$s2, $s2, 10	
	div	$s3, $t0
	mfhi	$t1
	sub	$s3, $s3, $t1	
	add	$t1, $s2, $s3	
	la 	$s0, r1
	add	$s0, $s0, $t1
	li	$t0, 0		
	li	$t1, 0		
check_3x3:
	beq	$t0, 9, check_return_true
	beq	$t1, 3, check_3x3_next_row
	lb	$t2, 0($s0)
	subi	$t2, $t2, 48
	beq	$t2, $s1, check_return_false
	addi	$t0, $t0, 1
	addi	$t1, $t1, 1
	addi	$s0, $s0, 1
	j	check_3x3
check_3x3_next_row:
	addi	$s0, $s0, 7
	li	$t1, 0	
	j	check_3x3	
check_return_true:
	li	$v0, 1
check_return:
	######end#####
	lw 	$ra, 28($sp)
	lw	$s0, 24($sp)
	lw	$s1, 20($sp)
	lw	$s2, 16($sp)
	lw	$s3, 12($sp)
	addu 	$sp, $sp, 32
	######end######
	jr	$ra
check_return_false:
	li	$v0, 0
	j	check_return
	

.data
r1:	.space 10
r2:	.space 10
r3:	.space 10
r4:	.space 10	
r5:	.space 10
r6:	.space 10
r7:	.space 10
r8:	.space 10	
r9:	.space 10
newline: .asciiz "\n"
