# calculation.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a0, $a1, $a2
#   make all returned values from functions go in $v0

#   int x = $a0, int y = $a1, int n = $a2
.text
conv:
    # CODE MISSING: Student to complete this part
    #int z=0
    li $t0, 0 #int z
    li $t1, 0 #int i
    li $t2, 0

loop:
    bge $t1, $a2, endL
    
    move $t3, $t0
    sll $t4, $a1, 2

    sub $t3, $t3, $a0
    add $t0, $t3, $t4

    li $t2, 2
    blt $a0, $t2, increment

    sub $a1, $a1, $a0


increment: 
    addi $a0, $a0, 1
    addi $t1, $t1, 1
    j loop
 endL: 
    move $v0, $t0
    jr $ra  
    
main:  # DO NOT MODIFY THE MAIN SECTION
    li $a0, 5
    li $a1, 7
    li $a2, 7

    jal conv

    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 10
    syscall