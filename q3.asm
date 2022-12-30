#q3 copy 20 words from one data block to another
.data 0x10010000
Array: .space 80 #init Array[80 bytes]==Array[20 words]
.text
la $a0,Array #$a0=Address of Array
li $a1,20 #$a1=20 words
jal Data_Block #init Array, using $a0 and $a1.
la $t0,Array #load address of Res to $t10
addi $t1,$0,20 #$t1=20. Used as index for loop.
Loop:
beq $t1,$0,END #if $t1==0 then finish, else continue
lw $t4,0($t0) #$t4=$t0[i] == $t4=Array[i]
sw $t4,0x100($t0) #assign $t4 to 0x10010100+4*index
addi $t0,$t0,4 #move one index in $t0
addi $t1,$t1,-1 #idx--
j Loop
END:
li $v0,10 #terminate program
syscall #execute


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