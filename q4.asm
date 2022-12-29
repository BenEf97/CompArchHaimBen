#q4
.data 0x10010000
Array: .space 80 #init Array[80 bytes]==Array[20 words]
.text
#init 1st array:
la $a0,Array #$a0=Address of Array
li $a1,20 #$a1=20 words
jal Data_Block #init Array, using $a0 and $a1.
#Init 2nd array:
la $a0,Array #$a0=0x10010000
addi $a0,$a0,0x100 #$a0=0x10010100
li $a1,20 #$a1=20 words
jal Data_Block #init Array, using $a0 and $a1

la $t0,Array #$t0=0x10010000
la $t1,Array #$t1=0x10010000
addi $t1,$t1,0x100 #$t1=0x10010100
addi $t4,$0,20 #$t4=20 used as idx
loop: 
beq $t4,$0,end 
lw $t2,0($t0) #$t2=$t0[idx]
lw $t3,0($t1) #$t3=$t1[idx]
sw $t2,0($t1) #t1[idx]=$t2
sw $t3,0($t0) #t0[idx]=$t3
addi $t0,$t0,4 #idx++
addi $t1,$t1,4 #idx++
addi $t4,$t4,-1 #$t4--
j loop 
end:
li $v0,10 #terminate program
syscall #execute
