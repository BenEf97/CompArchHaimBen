#Q7: Swap odd and even words.
.data 0x10010000
Array: .space 80 #init Array[80 bytes]==Array[20 words]
.text 
la $a0,Array #$a0=Address of Array
li $a1,20 #$a1=20 words
jal Data_Block #init data block
la $t0,Array #$t0=0x10010000
addi $t4,$0,10 #idx=10
Loop:
beq $t4,$0,END #if $t4==0 jump to END
lw $t1,0($t0) #$t1=$t0[even index]
lw $t2,4($t0) #$t2=$t0[odd index]
sw $t2,0($t0) #$t0[even idx]=$t2
sw $t1,4($t0) #$t0[odd idx]=$t1
addi $t0,$t0,8 #$t0+=2 moving to the next one
addi $t4,$t4,-1 #$t4--
j Loop
END:
li $v0,10 #terminate program
syscall
