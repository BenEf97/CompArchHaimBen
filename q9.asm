#Q9: Sum all the words in the data block and print it.
.data 0x10010000
Array: .space 80 #init Array[80 bytes]==Array[20 words]
.text 
la $a0,Array #$a0=Address of Array
li $a1,20 #$a1=20 words
jal Data_Block #init data block
la $t0,Array #$t0=0x10010000
li $t2,20 #$t2=20 idx
move $t1,$0 #$t1=0
Loop:
beq $t2,$0,END #if $t2==0 jump to END
lw $t3,0($t0) #$t3=$t0[idx]
add $t1,$t1,$t3 #$t1+=$t3
addi $t2,$t2,-1 #$t2--
addi $t0,$t0,4 #$t0[idx++]
j Loop
END:
li $v0,1 #print result
move $a0,$t1 
syscall
li $v0,10 #terminate program
syscall