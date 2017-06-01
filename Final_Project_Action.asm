INCLUDE Irvine32.inc
INCLUDE Player.inc
.data
player word 127
bullet word 111
right byte 'd'
left byte 'a'
up byte 'w'
down byte 's'
shoot byte 'k'
Rbound byte 187
Lbound byte 0
Ubound byte 0
Dbound byte 43
.code
Action PROC USES eax ebx ecx edx esi edi,
		playerX4: byte,
		playerY4: byte,
		bulletLocationX2: PTR DWORD,
		bulletLocationY2: PTR DWORD,
		playerPosition3: word,
		BulletLength3: DWORD,
		bulletPosition2: word
L:
	INVOKE Draw,
		bulletLocationX2,
		bulletLocationY2,
		playerX4,
		playerY4,
		playerPosition3,
		BulletLength3,
		bulletPosition2		
		
	mov eax, 20
	call Delay
	call ReadKey
	
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
	mov al, playerX4
	cmp al, Rbound
	jb	ContinueR
	pop eax
	jmp L
ContinueR:
	inc playerX4
	pop eax
	jmp L
WLEFT:
	push eax
	mov al, playerX4
	cmp al, Lbound
	ja	ContinueL
	pop eax
	jmp L
ContinueL:
	dec playerX4
	pop eax
	jmp L
WUP:
	push eax
	mov al, playerY4
	cmp al, Ubound
	ja	ContinueU
	pop eax
	jmp L
ContinueU:
	dec playerY4
	pop eax
	jmp L
WDOWN:
	push eax
	mov al, playerY4
	cmp al, Dbound
	jb	ContinueD
	pop eax
	jmp L
ContinueD:
	inc playerY4
	pop eax
	jmp L
FIRE:
	INVOKE Shooting,
		playerX4,
		playerY4,
		bulletLocationX2,
		bulletLocationY2,
		BulletLength3
	jmp L
	ret
Action endp
end