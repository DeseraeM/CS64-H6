# swap_case.asm program
# For CMPSC 64
#
# Data Area
.data
    buffer:         .space 100
    input_prompt:   .asciiz "Enter string:\n"
    output_prompt:  .asciiz "Output:\n"
    convention:     .asciiz "Convention Check\n"
    newline:        .asciiz "\n"

.text

#
# DO NOT MODIFY THE MAIN PROGRAM 
#       OR ANY OF THE CODE BELOW, WITH 1 EXCEPTION!!!
# YOU SHOULD ONLY MODIFY THE SwapCase FUNCTION 
#       AT THE BOTTOM OF THIS CODE
#
main:
    la $a0, input_prompt    # prompt user for string input
    li $v0, 4
    syscall

    li $v0, 8       # take in input
    la $a0, buffer
    li $a1, 100
    syscall
    move $s0, $a0   # save string to s0

    li $s1, 0
    li $s2, 0
    li $s3, 0
    li $s4, 0
    li $s5, 0
    li $s6, 0
    li $s7, 0

    move $a0, $s0
    jal SwapCase

    add $s1, $s1, $s2
    add $s1, $s1, $s3
    add $s1, $s1, $s4
    add $s1, $s1, $s5
    add $s1, $s1, $s6
    add $s1, $s1, $s7
    add $s0, $s0, $s1

    la $a0, output_prompt    # give Output prompt
    li $v0, 4
    syscall

    move $a0, $s0
    jal DispString

    j Exit

DispString:
    addi $a0, $a0, 0
    li $v0, 4
    syscall
    jr $ra

ConventionCheck:
    addi    $t0, $zero, -1
    addi    $t1, $zero, -1
    addi    $t2, $zero, -1
    addi    $t3, $zero, -1
    addi    $t4, $zero, -1
    addi    $t5, $zero, -1
    addi    $t6, $zero, -1
    addi    $t7, $zero, -1
    ori     $v0, $zero, 4
    la      $a0, convention
    syscall
    addi    $v0, $zero, -1
    addi    $v1, $zero, -1
    addi    $a0, $zero, -1
    addi    $a1, $zero, -1
    addi    $a2, $zero, -1
    addi    $a3, $zero, -1
    addi    $k0, $zero, -1
    addi    $k1, $zero, -1
    jr      $ra
    
Exit:
    li $v0, 10
    syscall

# COPYFROMHERE - DO NOT REMOVE THIS LINE

# YOU CAN ONLY MODIFY THIS FILE FROM THIS POINT ONWARDS:
SwapCase:
    #TODO: write your code here, $a0 stores the address of the string

    li $t0, 0

    addi $sp, $sp, -32
    sw $ra, 28($sp)
    sw $s1, 24($sp)
    sw $s2, 20($sp)
    sw $s3, 16($sp)
    sw $s0, 12($sp)
    move $s1, $a0
    move $s0, $a0   

loop:
    lb   $s2, 0($s1)
    beq  $s2, $zero, clean 

    li  $t0, 97  
    li  $t1, 122 
    slt $t2, $s2, $t0  
    bne $t2, $zero, upper

    slt $t2, $t1, $s2  
    bne $t2, $zero, upper
 
    addi $s3, $s2, -32
    j  print

upper:
    li $t0, 65  
    li $t1, 90

    slt $t2, $s2, $t0 
    bne $t2, $zero, skip

    slt $t2, $t1, $s2 
    bne $t2, $zero, skip

    addi $s3, $s2, 32
    j print

print: 
    sb $s2, 8($sp)
    sb $zero, 9 ($sp)
    li $v0, 4
    addi $a0, $sp, 8
    syscall

    li   $v0, 4
    la  $a0, newline 
    syscall
    

    sb $s3, 4($sp)       
    sb $zero, 5($sp)  
    li $v0, 4
    addi $a0, $sp, 4
    syscall
    
    li  $v0, 4
    la  $a0, newline 
    syscall

    sb $s3, 0($s1)
    jal ConventionCheck

skip:
    addi $s1, $s1, 1
    j loop 
    
clean:
    lw $s0, 12($sp)
    lw  $s3, 16($sp)
    lw  $s2, 20($sp)
    lw  $s1, 24($sp)
    lw $ra, 28($sp)
    addi $sp, $sp, 32
    # Do not remove the "jr $ra" line below!!!
    # It should be the last line in your function code!
    jr $ra



