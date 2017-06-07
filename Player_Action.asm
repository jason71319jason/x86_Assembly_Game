
INCLUDE lib.inc

.code
playerAction PROC USES eax ebx ecx edx esi edi,
		playerPos:coord,
		setPtr:ptr Bullet,
		BulletSize:DWORD,
		num:byte
L:
	INVOKE playerDraw,
		setptr,
		playerPos,
		BulletSize,
		num
		
	mov eax, 20
	call Delay
	call Readkey
	
	cmp al, right
	je WRIGHT
	
	cmp al, left
	je WLEFT
	
	cmp al, up
	je WUP
	
	cmp al, down
	je WDOWN
	
	cmp al, shoot
	je FIRE
	jmp L
	
WRIGHT:
	push eax
	mov al, byte ptr playerPos.x
	cmp al, Rbound
	jb	ContinueR
	pop eax
	jmp L
ContinueR:
	mov dh, byte ptr playerPos.y
	mov dl, byte ptr playerPos.x
	call Gotoxy
	mov ax, ' '
	call WriteChar
	inc playerPos.x
	pop eax
	jmp L
WLEFT:
	push eax
	mov al, byte ptr playerPos.x
	cmp al, Lbound
	ja	ContinueL
	pop eax
	jmp L
ContinueL:
	mov dh, byte ptr playerPos.y
	mov dl, byte ptr playerPos.x
	call Gotoxy
	mov ax, ' '
	call WriteChar
	dec playerPos.x
	pop eax
	jmp L
WUP:
	push eax
	mov al, byte ptr playerPos.y
	cmp al, Ubound
	ja	ContinueU
	pop eax
	jmp L
ContinueU:
	mov dh, byte ptr playerPos.y
	mov dl, byte ptr playerPos.x
	call Gotoxy
	mov ax, ' '
	call WriteChar
	dec playerPos.y
	pop eax
	jmp L
WDOWN:
	push eax
	mov al, byte ptr playerPos.y
	cmp al, Dbound
	jb	ContinueD
	pop eax
	jmp L
ContinueD:
	mov dh, byte ptr playerPos.y
	mov dl, byte ptr playerPos.x
	call Gotoxy
	mov ax, ' '
	call WriteChar
	inc playerPos.y
	pop eax
	jmp L
FIRE:
	INVOKE playerShooting,
		playerPos,
		setPtr,
		BulletSize,
		num
	jmp L
	ret
playerAction endp
end