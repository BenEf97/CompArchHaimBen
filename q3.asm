#q3 copy 20 words 
.data 0x10010100
Res: .space 80 #init Res[80 bytes]==Res[20 words]
.text
jal Data_Block #init 0x10010000 with random numbers, returns $t0 with Array address.
la $t1,Res #load address of Res to $t1.

# lw from Array ->Res->Sw from Res
addi $t3,$0,20 #$t3=20. Used as index for loop.

Loop:
beq $t3,$0,END #if $t3==0 then finish, else continue
lw $t4,0($t0) #$t4=$t0[i] == $t4=Array[i]
sw $t4,0($t1) #$t1[i]=$t4
addi $t0,$t0,4 #move one index in $t0
addi $t1,$t1,4 #move one index in $t1
subi $t3,$t3,-1 #idx--
j Loop
END: