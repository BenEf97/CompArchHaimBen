#Q5: Find maximum word in array.
.data 0x10010000
Array: .space 80 #init Array[80 bytes]==Array[20 words]
.text 
la $a0,Array #$a0=Address of Array
li $a1,20 #$a1=20 words
jal Data_Block
la $t0,Array
addi $t1,$0,-60 #$t1=-60 <-50 out of range. MAX
addi $t2,$0,20 #$t2=20, idx
loop:
beq $t2,$0,end #if $t2==0 then jump to end
lw $t3,0($t0) #$t3=$t0[idx]. 
slt $t4,$t3,$t1 #if $t3<$t1 then $t4=1, else $t4=0
beq $t4,1,Update #if $t4==1, no new max, jump to update the index
move $t1,$t3 #$t1=$t3 
Update:
addi $t0,$t0,4 #$t0[idx++]
addi $t2,$t2,-1 #$t2--
j loop
end:
li $v0,1
move $a0,$t1 
syscall
li $v0,10 #terminate program
syscall
