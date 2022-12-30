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

Data_Block:
#initial function commands:
addi $sp,$sp,-4
sw $s0, 0($sp)

#start of funciton:
add $t0,$a0,$0 #$t0=$a0, means that $t0 has the start of the block address
add $t1,$a1,$0 #$t1=$a1, means that $t1 has the number of words.
L1:
beq $t1,$0,END_DataBlock #if $t1==0 then jump to the END.
li $v0,42 #call for rand function.
li $a1,100 #sets $a0 to be in the range of 0<=$a0<=100.
syscall #$a0=Rand in the given range (0-100).
addi $a0,$a0,-50 #$a0-=50 to change the range -50<=$a0<=50.
sw $a0,0($t0) #$t0=$a0, store the random number in the array
addi $t0,$t0,4 #$t0+=4, go to next index in the array.
addi $t1,$t1,-1 #$t1-=1
j L1 #jump to L1 label
END_DataBlock: #end of function
lw $s0, 0($sp)
addi $sp, $sp, 4
jr $ra #return to main