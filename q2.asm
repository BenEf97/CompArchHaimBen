#Q2
#Store random numbers in range of [-50,50] in an array. Now as a function
#to do- check the conditions and check it works.
#Note: need to enable direct access in MARS in order to work.
.data 0x10010000
Array: .space 80 # init Array[80 bytes]==Array[20 words].
.globl Data_Block #access from directory folder

.text
Data_Block:
li $t0,20 #$t0=20
la $t1,Array #load address of Array to $t1.
L1:
beq $t0,$0,END #if $t0==0 then jump to the END.
li $v0,42 #call for rand function.
li $a1,100 #sets $a0 to be in the range of 0<=$a0<=100.
syscall #$a0=Rand in the given range (0-100).
addi $a0,$a0,-50 #$a0-=50 to change the range -50<=$a0<=50.
sw $a0,0($t1) #$t1=$a0, store the random number in the array
addi $t1,$t1,4 #$t1+=4, go to next index in the array.
addi $t0,$t0,-1 #$t0-=1
j L1 #jump to L1 label
END:
la $t0,A #load the desired address to $t0, save it later if needed
jr $ra