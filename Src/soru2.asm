#Mert Muslu 150120027
#Erkut Dönmez 150120051
#Gülsüm Ece Günay 150121539
.data 

array: .space 40    #10 element integer array
eleNum: .asciiz " Enter the number of elements in the array: "
mess: .asciiz " Enter 10 numbers to be stored in the array. "
output: .asciiz " Output: "
newline: .asciiz " - "
hata: .asciiz " Hata:"
    	.globl main
    	.text 
main:
    	jal read
    	
read:
    
	# take number of elements in array
	li $v0, 4
	la $a0, eleNum
	syscall
	li $v0, 5
	syscall
	move $t1, $v0 	#get size
	
	move $k0, $t1 	#hold size
	add $s5, $s5 ,$t1
	mul $s5, $s5, $s5
	
	la $t0, array 	# assign address of first element
	
	move $t2, $t1 	#hold size in bytes (max - 8) 
	sll  $t2, $t2, 2
	add $t0, $t0, $t2
	addi $t9, $t9, -1
	sw $t9, 0($t0)
	sub $t9, $t9, $t9
	
	la $t0, array
	addi $t2, $t2, -4
	
	
	
   	b readLoop
   		
   	jal GCD
   	
   	jr $ra
printa: 
	la $t0, array
	li $t2, 1
	j print
	
print:
    	lw,$t4, ($t0)
   	li,$v0,1
    	move $a0,$t4
    	syscall

   	slt $t5, $t2, $k0
    	addi $t2,$t2,1
  	addi $t0,$t0,4
  	li,$v0,4
	la $a0,newline
    	syscall
  	bne $t5,$zero,print
    	
    	li $v0, 10
    	syscall
    	
readLoop:
    	
   	li $v0, 4           #Print string
    	la $a0, mess        #load prompt
   	syscall
   	li $v0, 5           #read int
  	syscall 
  	sw $v0, 0($t0)       #store input in array 
  	addi $t0, $t0, 4
  	subi $t1, $t1, 1
   	beq  $t1, 0, firstEleAddress
	b readLoop
		
firstEleAddress: 
	la $t0, array
	j GCD
GCD:

	lw $s0, 0($t0)
	addi $t0, $t0, 4
	lw $s1, 0($t0)
	subi $t0, $t0, 4
	addi $t1, $t1, 1
	
	beq $t1, $s5, printa
	beq $s1, -1, printa
	
	slt $t5, $s0, $s1
	beq $t5, $zero, skip_swap
	
	#swapping
	move $t6, $s0 
	move $s0, $s1
	move $s1, $t6
	
skip_swap:

	move $a0, $s0
	move $a1, $s1  

calculate:

	beq $a1, $zero , checkCoPrime
	
	div $a0, $a1
	
	move $a0, $a1
	mfhi  $a1
	
	j calculate
checkCoPrime:
	bne $a0, 1, notCoPrime # if not coPrime go "notCoPrime"
	beq $a0, 1 ,CoPrime

CoPrime:
	addi $t0, $t0, 4
	j GCD
	
notCoPrime:

	mul $s0, $s0, $s1  
	div $s0, $s0, $a0
	sw $s0, 0($t0)
	
		
ReArray:

	
	beq $t3, $t2, MakeZeroLastElement
	
	addi $t4, $t4, 1
	addi $t3, $t3, 4
	add $t0, $t0, 4
	lw $s2, 4($t0)
	sw $s2, 0($t0)
	
	j ReArray

MakeZeroLastElement:
	
	
	mul $t8, $t4, 4
	sub $t0, $t0, $t8 # go initial address (not a[0], go to $s0 address)
	subi $k0, $k0, 1
	bne $t3, 0, reduceT3
	
	j GCD

reduceT3:
	sub $t3, $t3, $t3
	sub $t4, $t4, $t4
	la $t0, array
	j GCD



