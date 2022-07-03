datasg segment
tem db 6,7 dup  (0)
a dw 0
b dw 0
c dw 0
i dw 0
T1 dw 0
T2 dw 0
printf_a3 db 'a:$'
printf_b4 db 'b:$'
printf_c12 db 'c:$'
datasg ends
codesg segment
assume cs:codesg,ds:datasg
start:
MOV AX,datasg
MOV DS,AX
L1: mov AX, 0
mov a, AX
L2: mov AX, 1
mov b, AX


;PRINTF
L3:
lea dx,printf_a3
mov ah,9
int 21h
mov ax,a
xor cx,cx
mov bx,10
PT03:xor dx,dx
div bx
or dx,0e30h;0e:显示字符
push dx
inc cx
cmp ax,0;ZF=1则AX=0,ZF=0则AX！=0
jnz PT03;相等时跳转
PT13:pop ax
int 10h;显示一个字符
loop PT13
mov ah,0 
;int 16h ;键盘中断
;换行
mov dl,0dh
mov ah,2
int 21h
mov dl,0ah
mov ah,2
int 21h




;PRINTF
L4:
lea dx,printf_b4
mov ah,9
int 21h
mov ax,b
xor cx,cx
mov bx,10
PT04:xor dx,dx
div bx
or dx,0e30h;0e:显示字符
push dx
inc cx
cmp ax,0;ZF=1则AX=0,ZF=0则AX！=0
jnz PT04;相等时跳转
PT14:pop ax
int 10h;显示一个字符
loop PT14
mov ah,0 
;int 16h ;键盘中断
;换行
mov dl,0dh
mov ah,2
int 21h
mov dl,0ah
mov ah,2
int 21h


L5: mov AX, 0
mov i, AX
L6: mov AX, i
sub AX, 10
L7: jnc TheEnd;大于等于则跳转
add AX, b
mov T2, AX
L8: mov AX, a
L9: mov AX, T2
mov c, AX
L10: mov AX, b
mov a, AX
L11: mov AX, c
mov b, AX


;PRINTF
L12:
lea dx,printf_c12
mov ah,9
int 21h
mov ax,c
xor cx,cx
mov bx,10
PT012:xor dx,dx
div bx
or dx,0e30h;0e:显示字符
push dx
inc cx
cmp ax,0;ZF=1则AX=0,ZF=0则AX！=0
jnz PT012;相等时跳转
PT112:pop ax
int 10h;显示一个字符
loop PT112
mov ah,0 
;int 16h ;键盘中断
;换行
mov dl,0dh
mov ah,2
int 21h
mov dl,0ah
mov ah,2
int 21h


L13: mov AX, i
add AX, 1
mov i, AX
L14: jmp L6
TheEnd:nop
mov ax,4c00h; int 21h的4ch号中断，安全退出程序。
int 21h;调用系统中断
codesg ends
end start
