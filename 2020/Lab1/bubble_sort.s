.data
N: .word 10 # Number to find the factorial value of
str1: .string "Array: "
str2: .string "Sorted: \n"
str3: .string " "
str4: .string "\n"
data:
  .word 5 # 0x5
  .word 3 # 0x3
  .word 6 # 0x6
  .word 7 # 0x7
  .word 31 # 0x1f
  .word 23 # 0x17
  .word 43 # 0x2b
  .word 12 # 0xc
  .word 45 # 0x2d
  .word 1 # 0x1

.text
main:

        # Print the result to console

        la a1,str1
        jal ra,printfString

        la a1,str4
        li a0,4
        ecall

        jal ra,printArray

        jal ra,bubblesort

        la a1,str2
        jal ra,printfString

        jal printArray

        # Exit program
        li       a0, 10
        ecall


# t0:i
# t1:j
# t2:N
# t3:data
printfString:
    li a0,4
    ecall 
    ret


bubblesort:
    # save reg
    addi sp,sp,-8
    sw ra,0(sp)

    li t0,0
    lw t2,N
bubblesort_outer_for:
    bge t0,t2,bubblesort_outer_for_end
    addi t1,t0,-1
bubblesort_inner_for:
    # branch if not it is not satisified
    blt t1,zero,bubblesort_inner_for_end
    la t3,data
    slli t6,t1,2
    add t3,t3,t6
    lw t4,0(t3)
    lw t5,4(t3)
    bge t5,t4,bubblesort_inner_for_end

    la a0,data
    mv a1,t1
    jal ra,swap
    # inner loop end
    addi t1,t1,-1
    j bubblesort_inner_for

bubblesort_inner_for_end:
    # outer loop end
    addi t0,t0,1
    j bubblesort_outer_for
bubblesort_outer_for_end:
    # function complete
    lw ra,0(sp)
    addi sp,sp,8
    ret

swap:
    addi sp,sp,-24
    sw t0,0(sp)
    sw t1,8(sp)
    sw t2,16(sp)
    slli a1,a1,2
    add t1,a0,a1
    lw t0,0(t1)
    lw t2,4(t1)
    sw t2,0(t1)
    sw t0,4(t1)
    lw t0,0(sp)
    lw t1,8(sp)
    lw t2,16(sp)
    addi sp,sp,24
    ret

## t0 :i
## t1 : N
## t2: data
## t3:char of data
printArray:
    li t0,0
    lw t1,N

printArray_for:
    bge t0,t1,printArray_for_End
    
    la t2,data
    slli t4,t0,2
    add t2,t2,t4

    lb a1,0(t2)
    li a0,1
    ecall 

    la a1,str3
    li a0,4
    ecall 

    # i++
    addi t0,t0,1
    j printArray_for

printArray_for_End:
    la a1,str4
    li a0,4
    ecall 
    ret
		

	
	