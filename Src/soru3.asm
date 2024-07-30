#Mert Muslu 150120027
#Erkut Dönmez 150120051
#Gülsüm Ece Günay 150121539
.data
    input: .space 1600
    prompt: .asciiz "Enter a string to shuffle: "
    prompt2: .asciiz "shuffle: "
	output_message: .asciiz "output: "
.text 
    li $v0,4
    la $a0,prompt
    syscall

    li $v0,8
    la $a0,input
    li $a1,1600
    syscall

    li $v0,4
    la $a0,prompt2
    syscall

    li $v0,5
    syscall

    move $s0, $v0 #s0 n say?s?n? tutuyor

    li $t1,0 #stringing uzunlugunu hesaplamak icin

    la $t0,input #string arrayimizin baslangic adresi

sizeOfString:
    lb $t2,0($t0)
    move $t3,$t0
    beq $t2,$zero,end_counting

    addi $t1,$t1,1
    addi $t0,$t0,1

    j sizeOfString

end_counting:
    sub $t0,$t0,$t1  #t0'?n tekrardan baslangic adresini tutmas? icin degisen t0 degerini resetliyoruz
    subi $t1,$t1,1


start:
	li $t3, 0 # a = 0
	
	
first_for:

	addi $t3, $t3, 1 # a++
 	srlv $t2, $t1, $t3 # z = n / 2^a
	subi $t2, $t2, 1 # z -= 1

	move $t4, $t3 # c = a
	sllv $s2, $1 , $t3 # s2 = 2^a 
	  	
	li $t5, -1 # i = -1
		
second_for:
	
	addi $t5, $t5, 1 # i += 1
	
	add $t6, $t0, $t5 # t0 + i
	
	div $t7, $t1, $s2 # n / 2^a
	move $s1, $t7 #s1 = n / 2^a
	add $t7, $t6, $t7 # t0 + ( n / 2^a ) + i  
	
	lb $t8, 0($t6)   # C harfini t8'e yazd?k
	lb $t9, 0($t7)	 # U harfini t9'a yazd?k
	sb $t8, 0($t7)   # C harfini t7'nin adresine yazd?k
	sb $t9, 0($t6)   # U harfini t6'n?n adresine yazd?k
	
	blt $t5, $t2 ,second_for  # i <= z ise döngüye devam
	 
if:
	
	ble  $t3, 1, else # a<= 1 ise else'e git
	ble  $t4, $zero, else
	
	mul $s3, $s1, 2 # s3 = n / 2^(a-1)
	add $t5, $t5, $s3 # i += s3
	sub $t5, $t5, $s1 # i -= s1
	
	
	add $t2, $t2, $s3 # z += s3
	subi $t4, $t4, 1 # c--
	
	
	j second_for
	
else: 
	blt  $t3, $s0, first_for # a < shuffle 
printloop:
	li $v0, 4	# print the message for output
	la $a0, output_message
	syscall
	li $v0, 4	#print result str
	la $a0, 0($t0)	
	syscall
