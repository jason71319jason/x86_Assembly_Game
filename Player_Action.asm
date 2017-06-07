INCLUDE Irvine32.inc
INCLUDE Player.inc

right 	EQU 'd'
left 	EQU 'a'
up 		EQU 'w'
down 	EQU 's'
shoot 	EQU 'k'
Rbound 	EQU 187
Lbound 	EQU 2
Ubound 	EQU 7
Dbound 	EQU 43
.data
player word 127
bullet word 111

.code
Action PROC USES eax ebx ecx edx esi edi,
		playerX4: byte,
		playerY4: byte,
		bulletLocationX2: PTR DWORD,
		bulletLocationY2: PTR DWORD,
		playerPosition3: word,
		BulletLength3: DWORD,
		bulletPosition2: word,
		BulletNum2: byte
L:
	INVOKE Draw,
		bulletLocationX2,
		bulletLocationY2,
		playerX4,
		playerY4,
		playerPosition3,
		BulletLength3,
		bulletPosition2,
		BulletNum2
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
	mov dh, playerY4
	mov dl, playerX4
	call Gotoxy
	mov ax, ' '
	call WriteChar
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
	mov dh, playerY4
	mov dl, playerX4
	call Gotoxy
	mov ax, ' '
	call WriteChar
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
	mov dh, playerY4
	mov dl, playerX4
	call Gotoxy
	mov ax, ' '
	call WriteChar
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
	mov dh, playerY4
	mov dl, playerX4
	call Gotoxy
	mov ax, ' '
	call WriteChar
	inc playerY4
	pop eax
	jmp L
FIRE:
	INVOKE Shooting,
		playerX4,
		playerY4,
		bulletLocationX2,
		bulletLocationY2,
		BulletLength3,
		BulletNum2
	jmp L
	ret
Action endp
end