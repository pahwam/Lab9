######################################################
# Lab 9 template file
######################################################

######################################################
# .data is where variables will reside.
# We define the following below so you know what 
# their values are.
.data
.global lowercase_string
lowercase_string:
    // Specify a string ending with '\0'
    .asciz "ece 362 is awesome!"

// Align to 4bytes boundary as we have a string above
.balign 4
######################################################


######################################################
# All code goes in the .text section
.text

.global asm_strlen
asm_strlen:
    /* uint32_t asm_strlen(char *str)
     * Take in a pointer to a string and return
     * its length up to the null terminating
     * character `\0`
    **/   

    /* Enter your code after this comment */
    mv   x11, x10              # x11 str ptr
    li   x10, 0                # x10 len and return val
    beq  x11, x0, .Lstrlen_done

.Lstrlen_loop:
    lbu  x12, 0(x11)           # Load one char
    beq  x12, x0, .Lstrlen_done
    addi x11, x11, 1           # Advance next byte
    addi x10, x10, 1           # Count char
    jal  x0, .Lstrlen_loop

.Lstrlen_done:
    /* Enter your code above this comment */
    ret

.global asm_fib
asm_fib:
    /* void asm_fib(int *arr, uint32_t length)
     * Accept a pointer to an array of integer and
     * the length of the array, then generate fibonacci
     * series starting at `0` and store the result
     * back to the array `arr` at corresponding indices.
     **/

    /* Enter your code after this comment */
    beq  x10, x0, .Lfib_done  # Return if arr == NULL
    beq  x11, x0, .Lfib_done  # return if len == 0

    sw   x0, 0(x10)          # arr[0] = 0
    addi x11, x11, -1
    beq  x11, x0, .Lfib_done  # Stop if len = 1

    li   x12, 1
    sw   x12, 4(x10)         # arr[1] = 1
    addi x10, x10, 8         # Point to arr[2]
    addi x11, x11, -1

.Lfib_loop:
    beq  x11, x0, .Lfib_done
    lw   x12, -8(x10)        # arr[i - 2]
    lw   x13, -4(x10)        # arr[i - 1]
    add  x12, x12, x13
    sw   x12, 0(x10)         # arr[i] = arr[i - 2] + arr[i - 1]
    addi x10, x10, 4         # Advance one 32-bit int
    addi x11, x11, -1 
    jal  x0, .Lfib_loop

.Lfib_done:
    /* Enter your code above this comment */
    ret

.global asm_toUppercase
asm_toUppercase:
    /* void asm_toUppercase(char *str)
     * loop through an entire string and only convert
     * the lowercase letter to uppercase, leaving the
     * rest of the string intact
     **/

    /* Enter your code after this comment */
    beq  x10, x0, .Lupper_done  # Return if str == NULL
    li   x12, 'a'
    li   x13, 'z'

.Lupper_loop:
    lbu  x11, 0(x10)           # Load one char
    beq  x11, x0, .Lupper_done # Stop at '\0'
    blt  x11, x12, .Lupper_next # Skip if c < 'a'
    blt  x13, x11, .Lupper_next # Skip if 'z' < c

    addi x11, x11, -32         #  lowercase ASCII to uppercase
    sb   x11, 0(x10)           # Write back to same address

.Lupper_next:
    addi x10, x10, 1          
    jal  x0, .Lupper_loop

.Lupper_done:
    
    
    /* Enter your code above this comment */
    ret


######################################################