#Q8: Swap half words in a given word.
.data 0x10010000
Array: .space 80 #init Array[80 bytes]==Array[20 words]
.text 
la $a0,Array #$a0=Address of Array
li $a1,20 #$a1=20 words
jal Data_Block #init data block
la $t0,Array #$t0=0x10010000
addi $t4,$0,20 #idx=20
Loop:
beq $t4,$0,END #if $t4==0 jump to END
lh $t1,0($t0) #$t1=$t0[bottom half index]
lh $t2,2($t0) #$t2=$t0[upper half index]
sh $t2,0($t0) #$t0[upper half idx]=$t2
sh $t1,2($t0) #$t0[bottom half idx]=$t1
addi $t0,$t0,4 #$t0++ moving to the next one
addi $t4,$t4,-1 #$t4--
j Loop
END:
li $v0,10 #terminate program
syscall
