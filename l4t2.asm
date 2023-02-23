.model tiny
.data

s1 db "BITSLABIOT"
dat1 db 10 dup(?)
s2 db "IOT"
dat2 db 10 dup(?)
s3 db 8 dup(?)

.code
.startup

            lea si,s1
            lea di,s2
            lea bx,s3
            mov dx,di
            mov bp,si
            mov cx,00h

label0:     mov ah,[si]
            mov al,[di]
            cmp ah,al
            jz label1
            jnz label2

label1:     inc si
            inc di
            inc ch
            inc cl
            cmp cl,03h
            jz label3
            cmp ch,0ah
            jz label7
            jnz label0

label2:     cmp cl,00h
            jz t1
            jnz t2
t1:         inc si
            inc ch
t2:         mov di,dx
            mov cl,00h
            cmp ch,0ah
            jz label7
            jnz label0

label3:     sub si,03h
            mov dx,si
            mov si,bp
            mov di,bx
            ;inc dx
            add bp,0ah
            mov bx,bp

label4:     mov al,[si]
            mov [di],al
            inc si
            inc di
            cmp si,dx
            jz  label5
            jnz label4

label5:     add si,03h
            mov al,'*'
            mov [di],al
            inc di
            jmp label6

label6:     mov al,[si]
            mov [di],al
            inc si
            inc di
            cmp si,bx
            jae label7
            jb label6

label7:     nop

.exit
end