.model tiny
.data

str1 db 'Aakash Lawana','$'

;print str1 in reverse diagonal order in white text with black background
.code
.startup
;SET up display mode
;set up video mode to 80x25 text mode, 16  colors
    mov ah,00h
    mov al,03h
    int 10h

;load address of str1 and length counter and column postion into registers
    lea di,str1
    mov ah,02h
    mov bh, 00h
    mov bl,00001111b

;reverse the str1
    ; load the offset of
    ; the string
    lea SI, str1
    ; count of characters of the string
    MOV CX, 0dh
    LABEL1:
    ; again load the starting;
    ;address of the string
    lea SI, str1
        LOOP2:
        ;if count not equal to zero
        CMP CX,0
        JE EXIT
        ; pop the top of stack
        POP DX
        ; make dh, 0
        XOR DH, DH
        ; put the character of the;
        ;reversed string
        MOV [SI], DX
        ; increment si and;
        ;decrement count
        INC SI
        DEC CX
        JMP LOOP2
    EXIT:
    ; add $ to the end of string
    mov al,'$'
    MOV [SI], AL

;print str1 in reverse diagonal order in white text with black background
;set cursor position
        mov dh,00h
        mov dl,00h 
        mov ah,02h
        lea di,str1
        mov cx,0dh
;write a single character
LABEL2: push cx
        mov ah,09h
        mov al,[di]
        mov bh,00h
        mov bl,00001001b
        mov cx,1
        int 10h

;increment the row, column position
        pop CX
        inc dh
        inc dl
        inc di
        dec cx
        jnz LABEL2

;blocking function
;press % key to exit
END1:   mov ah,07h
        int 21h
        cmp al,"%"
        jnz END1

.exit


end