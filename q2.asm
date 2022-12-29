#Q2
#Store random numbers in range of [-50,50] in an array. Now as a function
#The function gets the following arguments:
#$a0=Start of Block Address
#$a1=Number of words
#The caller needs to assign space
#Note: need to enable direct access in MARS in order to work. To do that follow the instructions below:
#Open MARS->Click on 'Settings' tab->Check on "Assemble all files in directory".
.data 
.globl Data_Block #access from directory folder

.text
Data_Block:
addi $sp,$sp,-4
sw $s0, 0($sp)
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
END_DataBlock:
lw $s0, 0($sp)
addi $sp, $sp, 4
jr $ra #return to main