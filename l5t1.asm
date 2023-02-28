.model tiny
.data
prompt      db  'Enter a character: $'
a_msg       db  'The character is a$'
not_a_msg   db  'Not a$'
.code
org 100h

.code
.startup

start:
    mov ah, 09h
    lea dx, prompt
    int 21h
    
    mov ah, 01h
    int 21h
    mov bl, al
    
    cmp bl, 'a'
    je  a_found
    cmp bl, 'A'
    je  a_found
    
    mov ah, 09h
    lea dx, not_a_msg
    int 21h
    
    mov ah, 4ch
    int 21h
    
a_found:
    mov ah, 09h
    lea dx, a_msg
    int 21h
    
    mov ah, 4ch
    int 21h
    
.exit
end 

