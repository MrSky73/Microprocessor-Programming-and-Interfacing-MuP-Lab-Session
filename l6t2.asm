.model tiny
.data

str1 db	'Enter your name: $'
str2 db 'Enter your id: $'

max1 db	64 ; max character that can be entered
act1 db	? ; Characters entered
inp1 db	64 dup('$') ; store user entered value


max2 db	64 ; max character that can be entered
act2 db	? ; Characters entered
inp2 db 64 dup('$')   ;store user entered value

fname1 db 'name.txt',0
fname2 db 'id.txt',0
fname3 db 'splice.txt',0

handle1 dw ?
handle2 dw ?
handle3 dw ?


part1 db 13 dup('$')
part2 db 06 dup('$')

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
    lea dx, fname1
    mov cl, 01h
    Int 21h
    mov handle1, ax

    ;open file
    mov ah, 3dh
    mov al, 01h
    lea dx, fname1
    Int 21h
    mov handle1, ax

    ;write msg to file
    mov ah, 40h
    mov bx, handle1
    mov cx, 0dh
    lea dx, inp1
    int 21h

    ;close file
    mov ah, 3eh
    int 21h


    ; ask user to enter value
    LEA DX, str2
    Mov AH, 09h
    INT 21h

    ; get entires from user
    LEA DX, max2
    Mov AH, 0Ah
    INT 21h

    ; Create a new file
    mov ah, 3ch
    lea dx, fname2
    mov cl, 01h
    Int 21h
    mov handle2, ax

    ;open file
    mov ah, 3dh
    mov al, 01h
    lea dx, fname2
    Int 21h
    mov handle2, ax

    ;write msg to file
    mov ah, 40h
    mov bx, handle2
    mov cx, 0dh
    lea dx, inp2
    int 21h

    ;close file
    mov ah, 3eh
    int 21h


;//////////////////////////////////////////


    ;open f1
    mov ah, 3dh
    mov al, 00h
    lea dx, fname1
    Int 21h

    ;read 
    mov ah , 3fh
    mov bx, handle1
    mov cx, 0dh
    lea dx,part1
    int 21h

    ;close file
    mov ah, 3eh
    int 21h

    ;open f2
    mov ah, 3dh
    mov al, 00h
    lea dx, fname2
    Int 21h

    ;read 
    mov ah , 3fh
    mov bx, handle2
    mov cx, 06h
    lea dx,part2
    int 21h

    ;close file
    mov ah, 3eh
    int 21h

    ; Create a new file
    mov ah, 3ch
    lea dx, fname3
    mov cl, 01h
    Int 21h
    mov handle3, ax

    ;open f3
    mov ah, 3dh
    mov al,01h
    lea dx, fname3
    Int 21h
    mov handle3,ax

    ;write id
    mov ah,40h
    mov bx,handle3
    mov cx, 0dh
    lea dx, part1
    int 21h

    ;write part1
    mov ah,40h
    mov bx,handle3
    mov cx, 06h
    lea dx, part2
    int 21h

    ;close file
    mov ah, 3eh
    int 21h

.exit
end