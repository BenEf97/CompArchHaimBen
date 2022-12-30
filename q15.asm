#Q14: Get user input for a number, and count how many times that number is in the data block, and print the result.
#Note: The string is saved in the memory, check the ascii view to see it.
.data 0x10010000
outputA: .asciiz "Enter two numbers and I'll show you the sum, difference, product, quotient, and remainder.\n\nPlease Enter a number A: "
outputB: .asciiz "Please Enter a number B: "
outputSum: .asciiz "A+B= "
outputDif: .asciiz "\nA-B= "
outputProduct: .asciiz "\nA*B= "
outputDiv: .asciiz "\nA/B= "
outputRem: .asciiz "\nA%B= "
invalidDiv: .asciiz "\nCan't divided by 0!"
.text 
li $v0,4 #set up print
la $a0, outputA
syscall #print the string
li $v0,5 #call for input from user
syscall #input call A
add $t2,$0,$v0 #$t2=$v0
li $v0,4 #set up print
la $a0, outputB
syscall #print the string
li $v0,5 #call for input from user
syscall #input call B
add $t3,$0,$v0 #$t3=$v0 
#Sum:
add $t1,$t2,$t3 #$t1=$t2+$t3 is Sum=A+B
li $v0,4 #set up print
la $a0, outputSum
syscall #print the string
li $v0,1 #print result
move $a0,$t1 
syscall
#Sub:
sub $t1,$t2,$t3 #$t1=$t2-$t3 is Dif=A-B
li $v0,4 #set up print
la $a0, outputDif
syscall #print the string
li $v0,1 #print result
move $a0,$t1 
syscall
#Product:
mul $t1,$t2,$t3 #$t1=$t2*$t3 is Product=A*B
li $v0,4 #set up print
la $a0, outputProduct
syscall #print the string
li $v0,1 #print result
move $a0,$t1 
syscall
bne $t3,$0,Valid #if $t3!=0 then the input is valid, can dvide, else print error.
li $v0,4 #set up print
la $a0, invalidDiv
syscall #print the string
j END
Valid:
#Quotient:
li $v0,4 #set up print
la $a0, outputDiv
syscall #print the string
div $t2,$t3 #$t1=$t2/$t3 is Quotient=A/B
mflo $a0 #get quotient
mfhi $t1 #get remainder
li $v0,1 #print result
syscall
#Remainder:
li $v0,4 #set up print
la $a0, outputRem
syscall #print the string
li $v0,1 #print result
move $a0,$t1
syscall
END:
li $v0,10 #terminate program
syscall