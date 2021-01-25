.data
argument_M: .word 4 # Number to find the factorial value of
argument_N: .word 8 # Number to find the factorial value of
str1: .string "GCD value of "
str2: .string " and "
str3: .string " is "

.text
main:
        lw       a0, argument_M   # Load argument from static data
        lw       a1, argument_N   # Load argument from static data
        jal      ra, gcd # Jump-and-link to the 'fact' label

        # Print the result to console
        mv       a2, a0
        lw       a1, argument_N
        lw       a0, argument_M
        jal      ra, printResult

        # Exit program
        li       a0, 10
        ecall

gcd:
        # save register
        addi     sp, sp, -24
        sw       ra, 16(sp)
        sw       a1, 8(sp)
        sw       a0, 0(sp)

	
        # work
        bne     	a1, zero, n_neq_0
        addi  a0,a0,0



        # load register
        addi     sp, sp, 24
        jalr     zero, ra, 0
n_neq_0:


        # work
        rem t0, a0, a1
        addi  a0,a1,0
        addi  a1,t0,0
        jal      ra,gcd
        addi  a0,a0,0


        # load register
        lw       ra, 16(sp)
        addi     sp, sp,24 

        ret
	

# expects:
# a0: Value which factorial number was computed from
# a1: Factorial result
printResult:
        mv       t0, a0
        mv       t1, a1
        mv       t2, a2

        la       a1, str1
        li       a0, 4
        ecall

        mv       a1, t0
        li       a0, 1
        ecall

        la       a1, str2
        li       a0, 4
        ecall

        mv       a1, t1
        li       a0, 1
        ecall

         la      a1, str3
        li       a0, 4
        ecall

        mv       a1, t2
        li       a0, 1
        ecall

        ret

		
	
	