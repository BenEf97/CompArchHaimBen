#q3 copy 20 words 
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