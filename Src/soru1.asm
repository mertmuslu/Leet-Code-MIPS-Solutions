#Mert Muslu 150120027
#Erkut Dönmez 150120051
#Gülsüm Ece Günay 150121539
.data
prompt1: .asciiz "Please enter the coefficients: "
prompt2: .asciiz "Please enter the first two numbers of the sequence: "
prompt3: .asciiz "Enter the number you want to calculate (it must be greater than 1): "
output: .asciiz "Output: "
invalid_msg: .asciiz "Invalid input. Please enter a number greater than 1.\n"

.text
.globl main

main:
    # Print prompt for coefficients
    li $v0, 4
    la $a0, prompt1
    syscall
    
    # Read coefficients a and b
    li $v0, 5
    syscall
    move $t0, $v0    # Store a in $t0
    li $v0, 5
    syscall
    move $t1, $v0    # Store b in $t1
    
    # Print prompt for first two numbers
    li $v0, 4
    la $a0, prompt2
    syscall
    
    # Read first two numbers x0 and x1
    li $v0, 5
    syscall
    move $t2, $v0    # Store x0 in $t2
    li $v0, 5
    syscall
    move $t3, $v0    # Store x1 in $t3
    
    # Print prompt for n
    li $v0, 4
    la $a0, prompt3
    syscall
    
    # Read n
    li $v0, 5
    syscall
    
    move $t4, $v0    # Store n in $t4
    subi $t4, $t4, 2
    
    
    # Check if n is greater than 1
    ble $t4, 1, invalid_input
    
    # Call sequence calculation procedure
    jal sequence_calculation
    
    # Print result
    li $v0, 4
    la $a0, output
    syscall
    li $v0, 1
    move $a0, $t5
    syscall
    
    # Exit program
    li $v0, 10
    syscall
    
invalid_input:
    # Print error message for invalid input
    li $v0, 4
    la $a0, invalid_msg
    syscall
    j main
    
sequence_calculation:
    # Calculate sequence

    move $t7, $t4    # Counter for n
    
sequence_loop:
    # Calculate next number in sequence
    move $t5, $t2    # Initialize result with x0
    move $t6, $t3    # Initialize next number with x1
    mul $t8, $t0, $t6
    mul $t9, $t1, $t5
    add $t5, $t8, $t9
    subi $t5, $t5, 2
    
    # Update x0 and x1 for next iteration
    move $t2, $t3
    move $t3, $t5
    
    # Decrement counter
    subi $t7, $t7, 1
    
    # Check if counter is zero
    bgtz $t7, sequence_loop
    
    jr $ra
