# Quick sort algorithm in MIPS assembly

# define the partition function
partition:
    add $sp, $sp, -16      # make space for temporary variables
    sw $ra, 12($sp)        # save return address
    sw $s1, 8($sp)         # save $s1
    sw $s2, 4($sp)         # save $s2
    sw $s3, 0($sp)         # save $s3

    move $s1, $a0          # $s1 = array
    move $s2, $a1          # $s2 = low
    move $s3, $a2          # $s3 = high

    # choose the pivot as the last element
    lw $t0, ($s1)
    add $t1, $s1, $s3
    sll $t2, $t1, 2
    add $t3, $s1, $t2
    lw $t4, ($t3)
    sw $t4, ($s1)
    sw $t0, ($t3)

    addi $t5, $s2, -1      # i = low - 1
    add $t6, $s2, $s3      # j = high
loop:
    addi $t5, $t5, 1       # i++
    sll $t7, $t5, 2
    add $t8, $s1, $t7     # $t8 = &array[i]
    lw $t9, ($t8)          # $t9 = array[i]
    blt $t9, $t4, loop     # if array[i] < pivot, continue

    addi $t6, $t6, -1      # j--
    sll $t7, $t6, 2
    add $t8, $s1, $t7     # $t8 = &array[j]
    lw $t9, ($t8)          # $t9 = array[j]
    bgt $t9, $t4, loop     # if array[j] > pivot, continue

    bge $t5, $t6, done     # if i >= j, break out of loop

    lw $t10, ($t8)         # swap array[i] and array[j]
    sw $t10, ($t8)
    sw $t9, ($t7)
    j loop

done:
    lw $t11, ($s1)         # swap pivot with array[i]
    add $t12, $s1, $t5
    sll $t13, $t5, 2
    add $t14, $s1, $t13
    lw $t15, ($t14)
    sw $t15, ($s1)
    sw $t11, ($t14)

    lw $ra, 12($sp)        # restore $ra
    lw $s1, 8($sp)         # restore $s1
    lw $s2, 4($sp)         # restore $s2
    lw $s3, 0($sp)         # restore $s3
    add $sp, $sp, 16       # restore the stack pointer
    jr $ra                 # return

# define the quicksort function
quicksort:
    add $

