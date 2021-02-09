
.data
argument: .word 4 # Number to find the factorial value of
str1: .string "Fibonacci value of "
str2: .string " is "

.text
main:
        lw       a0, argument   # Load argument from static data
        jal      ra, fib       # Jump-and-link to the 'fact' label

        # Print the result to console
        mv       a1, a0
        lw       a0, argument
        jal      ra, printResult

        # Exit program
        li       a0, 10
        ecall

fib:
        addi     sp, sp, -32
        sw       s1, 24(sp)
        sw       s0, 16(sp)
        sw       ra, 8(sp)
        sw       a0, 0(sp)

	
        bne     	a0, zero, n_neq_0





        addi     a0, zero, 0
        addi     sp, sp, 32
        jalr     zero, ra, 0
n_neq_0:
        addi    t0,zero,1
        bne     a0,t0,n_neq_1
					




        addi     a0, zero, 1
        addi     sp, sp, 32
        jalr     zero, ra, 0

					
n_neq_1:
        addi     a0, a0, -1
        jal      ra,fib 
        addi     s0,a0,0

        lw       a0, 0(sp)
        addi     a0, a0, -2
        jal      ra,fib 
        addi     s1, a0, 0




        add      a0, s0, s1

        lw       ra, 8(sp)
        lw       s0, 16(sp)
        lw       s1, 24(sp)
        addi     sp, sp, 32

        ret
	

# expects:
# a0: Value which factorial number was computed from
# a1: Factorial result
printResult:
        mv       t0, a0
        mv       t1, a1

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

        ret

		
	
	