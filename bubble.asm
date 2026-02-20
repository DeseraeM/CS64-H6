# print_array.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a0, $a1
#   make all returned values from functions go in $v0

# Example array and alen - your code should work for any integer array of any length > 1.
.data
    array:  .word 6, 4, 0, 1, 2, 9, 3, 5, 8, 7
    alen:   .word 10
    newline: .asciiz "\n"
    space:  .asciiz " "

.text
bubble:
    # CODE MISSING: Student to complete this part

    la $s0, array
    la $s1, alen
    lw $t8, 0($a1)
    addi $t1, $t8, -1 
    li $t0, 0

o_loop:
    blt $t1, $zero, return
    li $t2, 1

in_loop:
    bgt $t2, $t1, decrement

    la $s0, array
    
    sll $t3, $t2, 2
    addu $t3, $s0, $t3
    move $t6, $t3
    lw $t3, 0($t3) 

    addi $t4, $t2, -1 
    sll $s1, $t4, 2
    addu $s1, $s0, $s1
    move $t7, $s1 
    lw $s1, 0($s1)

    bge $t3, $s1,skip 

    move $t5, $s1 
    move $t0, $t3

    move $t3, $s1
    move $s1, $t0

    sw $t3, 0($t6)
    sw $s1, 0($t7)

skip: 
    addi $t2, $t2, 1
    j in_loop

decrement:
    addi $t1, $t1, -1
    j o_loop

printArray:
	# CODE MISSING: Student to complete this part
    li $s5, 0
    lw $s3, 0($a1)
loop: 
    bge $s5, $s3,  print
    la $s0, array
    sll $s4, $s5, 2
    addu $s4, $s0, $s4
    move $s6, $s4
    lw $s4, 0($s6)

    li $v0, 1
    move $a0, $s4
    syscall 

    li $v0, 4
    la $a0, space
    syscall

    addi $s5, $s5, 1
    j loop

print: 
    li $v0, 4
    la $a0, newline
    syscall

return:
    jr $ra 

main:
    la $a0, array
    la $a1, alen
    jal printArray

    la $a0, array
    la $a1, alen
    jal bubble

    la $a0, array
    la $a1, alen
    jal printArray

    li $v0, 10
    syscall	