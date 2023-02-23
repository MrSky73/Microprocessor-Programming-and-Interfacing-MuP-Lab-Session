.model tiny
.data
dat1 db 'wasitacatisaw'
dat1length db 0dh
res dw 00h
.code
.startup

; Initialize the variables
            lea ax,res 
            lea bx, dat1 
            mov si, 0             
            mov di, 0dh 
            sub di, 1 
            mov dl, [bx + si] 
            mov dh, [bx + di] 

; Loop to compare the characters
CompareLoop:cmp si, di 
            jae EndLoop
            cmp dl, dh
            jne NotPalindrome 
            inc si
            dec di
            mov dl, [bx + si] 
            mov dh, [bx + di]
            jmp CompareLoop 

NotPalindrome:mov BYTE PTR [res], 0 
            jmp EndProg

EndLoop:    mov BYTE PTR [res], 1
EndProg:


.exit
end