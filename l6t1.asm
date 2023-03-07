.model tiny
.data

str1 db	'Enter your name: $'

max1 db	32 ; max character that can be entered
act1 db	? ; Characters entered
inp1 db	32 dup('$') ; store user entered value 

fname db 'testing.txt',0
handle dw ?

.code
.startup

    ; ask user to enter value
    LEA DX, str1
    Mov AH, 09h
    INT 21h

    ; get entires from user
    LEA DX, max1
    Mov AH, 0Ah
    INT 21h

    ; Create a new file
    mov ah, 3ch
    lea dx, fname
    mov cl, 01h
    Int 21h
    mov handle, ax

    ;open file
    mov ah, 3dh
    mov al, 01h
    lea dx, fname
    Int 21h
    mov handle, ax

    ;write msg to file
    mov ah, 40h
    mov bx, handle
    mov cx, 0Ah
    lea dx, inp1
    int 21h

    ;close file
    mov ah, 3eh
    int 21h

.exit
end