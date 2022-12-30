#Q11: Count all the positive numbers
.data 0x10010000
Array: .space 80 #init Array[80 bytes]==Array[20 words]
.text 
la $a0,Array #$a0=Address of Array
li $a1,20 #$a1=20 words
jal Data_Block #init data block
la $t0,Array #$t0=0x10010000
li $t2,20 #$t2=20 idx
li $t1,0 #t1=0 counter
Loop:
beq $t2,$0,END #if $t2==0 jump to END
lw $t3,0($t0) #$t3=$t0[idx]
slt $t4,$0,$t3 # if 0<$t3 then $t4
beq $t4,$0,Update #if $t4==0 then jump to update, else increase the count
addi $t1,$t1,1 #$t1++ increase counter
Update:
addi $t2,$t2,-1 #$t2--
addi $t0,$t0,4 #$t0[idx++]
j Loop
END:
li $v0,1 #print result
move $a0,$t1 
syscall
li $v0,10 #terminate program
syscall