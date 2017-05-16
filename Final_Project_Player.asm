INCLUDE Irvine32.inc

	
main     EQU start@0
.data
startY byte 39
startX byte 10
player word 127
right byte 'd'
left byte 'a'
up byte 'w'
down byte 's'
char BYTE ?

.code

main proc

	call Clrscr
	mov dh, startY
	mov dl, startX 
	call Gotoxy
	mov ax, player
	call WriteChar
	mov dh, bulletY
	mov dl, bulletX
	call Gotoxy
	mov ax, bullet
	call WriteChar
L:
	mov eax, 10
	call Delay
	call ReadChar
	mov  char, al
	call Clrscr
	cmp al, right
	je WRIGHT
	
	cmp al, left
	je WLEFT
	
	cmp al, up
	je WUP
	
	cmp al, down
	je WDOWN
	
	cmp al, BCR
	je changeR
	
	cmp al, BCL
	je changeL
	jmp L1
WRIGHT:
	inc startX
	inc bulletX
	jmp L1
WLEFT:
	dec startX
	dec bulletX
	jmp L1
WUP:
	dec startY
	dec bulletY
	jmp L1
WDOWN:
	inc startY
	inc bulletY
	jmp L1
changeR:
	push eax
	mov al, bulletX
	cmp al, startX
	jb LessX1
	je EqualX1
	ja MoreX1
	MoreX1:
		push eax
		mov al, bulletY
		cmp al, startY
		jb LessY1
		je EqualY1
		ja MoreY1
		LessY1:
			inc bulletY
			jmp exit1
		EqualY1:
			inc bulletY
			jmp exit1
		MoreY1:
			dec bulletX
		exit1:	
			pop eax
			jmp exit4
	EqualX1:
		push eax
		mov al, bulletY
		cmp al, startY
		jb LessY2
		je EqualY2
		ja MoreY2
		LessY2:
			inc bulletX
			jmp exit2
		EqualY2:
			jmp exit2
		MoreY2:
			dec bulletX
		exit2:	
			pop eax
			jmp exit4		
	LessX1:
		push eax
		mov al, bulletY
		cmp al, startY
		jb LessY3
		je EqualY3
		ja MoreY3
		LessY3:
			inc bulletX
			jmp exit3
		EqualY3:
			dec bulletY
			jmp exit3
		MoreY3:
			dec bulletY
		exit3:	
			pop eax
			jmp exit2
	exit4:
		pop eax
		jmp L1
changeL:
	push eax
	mov al, bulletX
	cmp al, startX
	jb LessX2
	je EqualX2
	ja MoreX2
	MoreX2:
		push eax
		mov al, bulletY
		cmp al, startY
		jb LessY4
		je EqualY4
		ja MoreY4
		LessY4:
			dec bulletX
			jmp exit5
		EqualY4:
			dec bulletY
			jmp exit5
		MoreY4:
			dec bulletY
		exit5:	
			pop eax
			jmp exit8
	EqualX2:
		push eax
		mov al, bulletY
		cmp al, startY
		jb LessY5
		je EqualY5
		ja MoreY5
		LessY5:
			dec bulletX
			jmp exit6
		EqualY5:
			jmp exit6
		MoreY5:
			inc bulletX
		exit6:	
			pop eax
			jmp exit8	
	LessX2:
		push eax
		mov al, bulletY
		cmp al, startY
		jb LessY6
		je EqualY6
		ja MoreY6
		LessY6:
			inc bulletY
			jmp exit7
		EqualY6:
			inc bulletY
			jmp exit7
		MoreY6:
			inc bulletX
		exit7:	
			pop eax
			jmp exit8
	exit8:
		pop eax
		jmp L1
L1:
	mov dh, startY
	mov dl, startX
	call Gotoxy
	mov ax, player
	call WriteChar
	mov dh, bulletY
	mov dl, bulletX
	call Gotoxy
	mov ax, bullet
	call WriteChar
	loop L2
L2:
	jmp L
	call WaitMsg

main endp
end main
