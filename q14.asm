#Q14: Get user input for a number, and count how many times that number is in the data block, and print the result.
#Note: The string is saved in the memory, check the ascii view to see it.
.data 0x10010000
Array: .space 80 #init Array[80 bytes]==Array[20 words]
output: .asciiz "Please Enter a number to find at the array: "
.text 
la $a0,Array #$a0=Address of Array
li $a1,20 #$a1=20 words
jal Data_Block #init data block
li $v0,4 #set up print
la $a0, output
syscall #print the string
li $v0,5 #call for input from user
syscall #input call
la $t0,Array #$t0=0x10010000
add $t1,$0,$0 #$t1=0, used as counter
li $t2,20 #$t2=20 idx
Loop:
beq $t2,$0,END #if $t2==0 jump to END
lw $t3,0($t0) #$t3=$t0[idx]
bne $t3,$v0,Update #if $t3!=$v0 then update index, else update counter
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