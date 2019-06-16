disp_msg macro msg
lea dx,msg
mov ah,9
int 21h
endm
disp macro 
lea bx,table1
xlat
mov dl,al
mov ah,2
int 21h
endm
initialize macro word
mov al,word
mov dx,44a3h
out dx,al
endm


assume ds:data,cs:code
data segment
cw db 90h
ops db 3 dup(?)
table1 db "0123456789.+-"
msg1 db "not supported$"
data ends
code segment

start:
mov ax,data
mov ds,ax
initialize cw
call readkp 
call delay 
mov ops,al
disp 
call readkp 
call delay
mov ops+1,al
disp
call readkp 
call delay
mov ops+2,al
disp
mov dl,'='
mov ah,2
int 21h
cmp ops+1,0bh 
jne next
mov al,ops 
add al,ops+2 
daa 
mov cl,4
mov ah,0
shl ax,cl
shr al,cl
add ax,3030h 
mov dl,ah
mov ah,2
push ax
int 21h
pop ax
mov dl,al
mov ah,2
int 21h
jmp finish

next:
mov al,ops+1
cmp al,och 
jne disp_err 
mov al,ops 
sub al,ops+2
cmp al,09
jle noneed
neg al
mov dl,'-'
mov ah,2
push ax
int 21h
pop ax

noneed:
add al,30h
mov dl,al
mov ah,2
int 21h
jmp finish
disp_err:
disp_msg msg1 
finish: mov ah,4ch
int 21h
readkp proc 

try_again:
mov bl,01
mov bh,03
mov cl,00
next_row:
mov al,bl
mov dx,44a2h
out dx,al
mov dx,44a0h
in al,dx
cmp al,00h
jne scode
add cl,08h
rol bl,1
dec bh
jnz next_row
jmp try_again

scode:
ror al,1
jc return
inc cl
jmp scode
return: mov al,cl
ret
readkp endp
delay proc
mov si,03fffh
l2: mov di,0ffffh
l1: dec di
jnz l1
dec si
jnz l2
ret
delay endp
code end
end start



