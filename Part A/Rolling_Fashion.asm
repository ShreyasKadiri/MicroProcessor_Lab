assume cs:code,ds:data
data segment
pa equ 44A0h
pb equ 44A1h
pc equ 44A2h
cr equ 44A3h
msg db 61h,0f5h,9fh,71h,0ffh,31h,0e3h,61h,0d1h,0ffh,61h,0f5h,61h,0d1h
data ends
code segment
start:
mov ax,data
mov ds,ax

rpt:
mov cx,14d
lea si,msg
next_char:
mov al,[si]
call disp
call delay 
inc si
loop next_char
mov ah,06h
mov dl,0ffh
int 21h
jz rpt
mov ah,4ch
int 21h
disp proc
push cx
mov cx,8

next_bit:
mov dx,pb
out dx,al
push ax
mov al,0ffh
mov dx,pc
out dx,al
mov al,00h
out dx,al
pop ax
ror al,1
loop next_bit
pop cx
ret
disp endp
delay proc
mov bx,02fffh
l2: mov di,0ffffh
l1: dec di
jnz l1
dec bx
jnz l2
ret
delay endp
code ends
end start