.model tiny
.data
max1 db 32
Act1 db ?
Inp db 32 dup(0)
.code
.startup
    LEA DX,max1
    MOV AH,0Ah
    int 21h
    lea BX,Inp
    LEA SI,Act1
    MOV CH,00   
    MOV CL,[SI]
    JNZ X1
X1:
    MOV DI,20h
    sub [BX],DI
    mov AX,00
    mov DL,BL
    MOV AH,02h  
    INT 21h
    INC BX
    DEC CL
    JNZ X1
.exit
end 