.model tiny
.data

msg1 db "enter User Name: $"
; usn1 db	"anub@g.com$" 
max1 db	20h ; max character that can be entered
act1 db	? ; Characters entered
inp1 db	20h dup('$') ; store user entered value 



msg2 db "enter password:$"
; pass1 db "oscar"
max2 db 20h ; max character that can be entered
act2 db ? ; Characters entered
inp2 db 20h dup ("$") ; Buffer to store user's input for password
msg3 db "hello $" ; Message 3: Greeting message when both
msg4 db "wrong username$" ; Message 4: Wrong username input
msg5 db "wrong password$" ; Message 5: Wrong password input
nline db 0ah, 0dh, "$" ; New line characters


fname1 db 'user.txt',0
fname2 db 'pswd.txt',0

handle1 dw ?
handle2 dw ?

part1 db 20h dup('$')
part2 db 20h dup('$')

.code
.startup
; Display message 1 on the screen and go to the next line
    lea dx, msg1
    mov ah, 09h
    int 21h

    ; Add a new line after the message.
    lea dx, nline    
    mov ah, 09h
    INT 21h

; Take input from the user and store it in inp1.
    lea dx, max1
    mov ah, 0ah
    int 21h


;open username file
    mov ah, 3dh
    mov al, 00h
    lea dx, fname1
    Int 21h
    mov handle1, ax

;read 
    mov ah , 3fh
    mov bx, handle1
    lea di,act1
    mov cx, [di]
    lea dx,part1
    int 21h

; Compare the entered username with the stored username.
    cld
    lea di, inp1
    lea si, part1
    mov cx, 11
    repe cmpsb
    jcxz l1

; If the username is incorrect, display the "wrong username"message and exit.    
    lea dx, nline
    mov ah, 09h
    int 21h
    lea dx, msg4
    mov ah, 09h
    int 21h
    mov ah, 4ch
    int 21h

; If the username is correct, display the "enter password" message
l1: 
    lea dx, nline
    mov ah, 09h
    int 21h
    lea dx, msg2
    mov ah, 09h
    int 21h
    lea dx, nline
    mov ah, 09h
    int 21h

; Take password input from the user, masking the characters
    lea di, max2
    mov cx, [di]
    lea di, inp2
l2:
    mov ah, 08h
    int 21h
    mov [di], al
    mov dl, '*'
    mov ah, 02h
    int 21h
    inc di
    dec cx
    jnz l2

;open username file
    mov ah, 3dh
    mov al, 00h
    lea dx, fname2
    Int 21h
    mov handle2, ax

;read 
    mov ah , 3fh
    mov bx, handle2
    lea di,act2
    mov cx, [di]
    lea dx,part2
    int 21h

; Compare the entered password with the stored password.
    cld
    lea di,act2
    mov cx, [di]
    lea di, inp2
    lea si, part2
    repe cmpsb
    jcxz l3

; If the password is incorrect, display the "wrong password" message and exit.
    lea dx, nline
    mov ah, 09h
    int 21h
    lea dx, msg5
    mov ah, 09h
    int 21h
    mov ah, 4ch
    int 21h

; If the password is correct, display the greeting message and the username.
l3: 
    lea dx, nline
    mov ah, 09h
    int 21h
    lea dx, msg3
    mov ah, 09h
    int 21h
    lea dx, part1
    mov ah, 09h
    int 21h
    lea dx, nline
    mov ah, 09h
    int 21h
.exit
end