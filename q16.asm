#Q16: Turn all the characters in 'Allice.txt' to caps. Please read the note!!!!!
###NOTE: the file must be at the same directory as MIPS.jar###
.data 0x10010000
Allice: .asciiz "Allice.txt" 
AlliceU: .asciiz "AlliceU.txt"
ErrorOutput: .asciiz "Error! Exiting the program..."
ReserveSpace: .space 2000 #reserved space
.text
#Open 'Allice.txt'
la $a0,Allice #get address of Allice
li $v0,13 #Open file mode
li $a1,0 #Open for read only
li $a2,0 #mode is ignored (from Help)
syscall

#Check for errors:
slt $t0,$0,$v0 #check for error, if $v0 is negative then error.
bne $t0,$0,Continue1 #if $t0!=0 then it worked, continue.
li $v0,4 #set up print
la $a0, ErrorOutput
syscall #print the string
j END

Continue1:
#Read 'Allice.txt'
move $a0,$v0 #save the file descriptor

###Debug###
#li $v0,16 #close 'Allice.txt'
#syscall

li $v0,14 #Read file mode
la $a1,ReserveSpace #get address for output buffer
li $a2,2000 #maximum characters to read
syscall

#Check for error
slt $t0,$0,$v0 #check for error, if $v0 is negative then error.
bne $t0,$0,Continue2 #if $t0!=0 then it worked, continue.
li $v0,4 #set up print
la $a0, ErrorOutput
syscall #print the string
j END

#Replace all the minor characters
Continue2:
move $s5,$v0 #save the file descriptor
addi $t8,$0,97 #$t8='a'
addi $t9,$0,122 #$t9='z'

Loop:
lb $t2,0($a1) #$t2=$a1[idx]
blt $t2,$t8,Cap #if $t2<'a' then jump to Cap, else continue
bgt $t2,$t9,Cap #if $t2>'z' then jump to Cap, else continue
#minor characters is found
addi $t2,$t2,-32 #Turn $t2 to a Cap.
sb $t2,0($a1) #$a1[i]=$t2 now Cap.
Cap:
addi $a1,$a1,1 #a1[idx++]
lb $t1,0($a1) #$t1=$a1[idx]
bne $t1,$0,Loop #if $t1!='\0' then continue the loop
#Write 'AlliceU.txt'
la $a0, AlliceU #address of 'AlliceU.txt'
li $v0,13 #open file
li $a1,1 #Create file if needed
li $a2,0
syscall
move $a0,$v0 #$a0=$t1 for file descriptor for AlliceU
la $a1,ReserveSpace #load buffer address for $a1
move $a2,$s5 #load num of characters to write to $a2
li $v0,15 #read file
syscall

END:
li $v0,16 #close 'AlliceU.txt'
syscall
li $v0,16 #close 'Allice.txt'
la $a0,Allice
syscall
li $v0,10 #terminate program
syscall
