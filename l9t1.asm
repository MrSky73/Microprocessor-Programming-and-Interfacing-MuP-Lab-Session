.model tiny
.data

inp1 db ?
rowstr dw ?
rowend dw ?
colmstr dw ?
colmend dw ?
cnt db ?

;file names and file handles
fname1 db "lab1.txt", 0
handle1 dw ?

msg1 db "enter a character: $"

part1 db 15 dup('$')


.code
.startup

; Display message 1 on the screen and go to the next line
    lea dx, msg1
    mov ah, 09h
    int 21h

;take a single character input from the user and do not echo it on the screen ans store it in inp1
    mov ah, 01h
    int 21h
    mov bl, al
    push bx

;open the file lab1.txt in read mode and store the file handle in handle1
    lea dx, fname1
    mov ah, 3dh
    int 21h
    mov handle1, ax

;store the contents of the file in part1
    mov ah, 3fh
    mov bx, handle1
    mov cx, 15
    lea dx, part1
    int 21h

;close the file
    mov ah, 3eh
    mov bx, handle1
    int 21h

; compare the entered character with the 12st character of the file
    pop bx
    lea si, part1
    cmp bl, 'a'
    je l1
    mov cnt, 0
    jmp init

l1:
    mov cnt, 1
    jmp init

; Initialize parameters for box drawing
init:
    MOV rowstr, 10
    MOV rowend, 20
    MOV colmstr, 10
    MOV colmend, 410

; Set display mode to 640x480 16 colors
    MOV AH, 00H
    MOV AL, 12H
    INT 10H

    ; Set cursor position to (25, 25)
    MOV AH, 02H
    MOV DH, 10
    MOV DL, 10
    MOV BH, 00
    INT 10H


    ; Paint the first box
PAINT1:
    add rowstr, 10
    add rowend, 10
    MOV SI, rowstr ; Row start
    COLM1:
    MOV CX, colmend ; Column end
    ROW1:
    DEC CX
    MOV DI, CX
    PUSH CX

;check if cnt is odd or even 
    MOV AL, cnt
    AND AL, 1
    jnz ODD


    MOV AH, 0Ch
    MOV AL, 1101b ; Color magenta
    MOV CX, DI
    MOV DX, SI
    INT 10h
    JMP COMMON

ODD:
    MOV AH, 0Ch
    MOV AL, 1010b ; Color green
    MOV CX, DI
    MOV DX, SI
    INT 10h
    JMP COMMON



COMMON:
    POP CX
    CMP CX, colmstr ; Column start
    JNZ ROW1
    INC SI
    MOV AX, rowend ; Row end
    CMP SI, AX
    JNZ COLM1
    inc cnt
    cmp cnt, 19
    jnz PAINT1


END1:
    MOV AH, 07H
    INT 21h
    CMP AL, "%"
    JNZ END1 ; Loop until '%' is received

    TERM:
    MOV AH, 4CH ; Terminate program
    INT 21H



.exit
end
