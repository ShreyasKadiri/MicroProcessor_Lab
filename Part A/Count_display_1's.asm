assume cs:code,ds:data
data segment
pa equ 44A0h
pb equ 44A1h
pc equ 44A2h
cr equ 44A3h
msg db "No. of 1's";
ones db ?,"$";
data ends

code segment
start:
mov ax,data
mov ds,ax
mov dx,cr
mov al,82h 
out dx,al
mov dx,pb
in al,dx 
mov cx,8
mov ah,00
rot_again:
ror al,1
jnc next
inc ah 
next:
loop rot_again



mov bl,ah 
add ah,30h
mov ones,ah
lea dx,msg
mov ah,09h
int 21h
mov al,00h
ror bl,1 
jc disp
mov al,0ffh
disp:
mov dx,pa
out dx,al
mov ah,4ch
int 21h
code ends
end start