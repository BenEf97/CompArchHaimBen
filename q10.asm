#Q10: Sum a[i]=a[i]+a[i+1], i=0,2,4...
.data 0x10010000
Array: .space 80 #init Array[80 bytes]==Array[20 words]
.text 
la $a0,Array #$a0=Address of Array
li $a1,20 #$a1=20 words
jal Data_Block #init data block
la $t0,Array #$t0=0x10010000
li $t2,10 #$t2=10 idx
Loop:
beq $t2,$0,END #if $t2==0 jump to END
lw $t3,0($t0) #$t3=$t0[idx]
lw $t4,4($t0) #$t4=$t0[idx+1]
add $t3,$t3,$t4 #$t3+=$t4
sw $t3,0($t0) #$t0[idx]=$t3
addi $t2,$t2,-1 #$t2--
addi $t0,$t0,8 #$t0[idx++]
j Loop
END:
li $v0,10 #terminate program
syscall