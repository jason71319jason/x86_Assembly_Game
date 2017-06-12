
INCLUDE lib.inc

bulletCollision proto, bulletLoc:ptr bullet
.code
BulletPrint proc uses eax ebx ecx edx esi,
	bulletSetPtr:ptr bullet,
	bulletNum:dword,
	playerPosi:coord
	
	mov eax, 240
	call setTextColor
	mov ecx, bulletNum
	mov esi, bulletSetPtr
L:	
	cmp (bullet ptr [esi]).isExist, 0
	je post
	mov dl, byte ptr (bullet ptr [esi]).co.x
	mov dh, byte ptr (bullet ptr [esi]).co.y
	
	cmp dl, byte ptr playerPosi.x
	je check
	jmp clean
check:
	cmp dh, byte ptr playerPosi.y
	je delta
clean:

	invoke bulletCollision, esi
	cmp ebx, 1
	je postDo
	
	call gotoxy
	mov al, 32
	call writechar
delta:
	add dl, (bullet ptr [esi]).deltaX   
	add dh, (bullet ptr [esi]).deltaY
	mov byte ptr (bullet ptr [esi]).co.x, dl
	mov byte ptr (bullet ptr [esi]).co.y, dh
	
		
	invoke getToolPos
	cmp ax, (bullet ptr [esi]).co.x
	jne posCheck
	cmp bx, (bullet ptr [esi]).co.x
	jne posCheck
	invoke cantUseToolKind
	
posCheck:
	.if dl > Rbound || dl < Lbound
	mov (bullet ptr [esi]).isExist, 0
	invoke deltaOfBulletNum, -1
	jmp postDo
	.endif
	
	.if dh > Dbound || dh < Ubound
	mov (bullet ptr [esi]).isExist, 0
	invoke deltaOfBulletNum, -1
	jmp postDo
	.endif
	
	invoke bulletCollision, esi

	cmp (bullet ptr [esi]).isExist, 0
	je postDo
	call gotoxy
	mov al, bulletIcon
	call writechar
	jmp postDo
post:
	inc ecx
postDo:
	add esi, type bullet
	dec ecx
	cmp ecx, 0
	jne L
	
	ret
BulletPrint endp

bulletCollision proc uses ecx eax edx edi esi,
	bulletLoc:ptr bullet
	
	mov ebx, 0
	mov edi, bulletLoc
	mov dl, byte ptr (bullet ptr [edi]).co.x
	mov dh, byte ptr (bullet ptr [edi]).co.y
	invoke getEnemySet
	invoke getEnemyNum
	mov ecx, eax
L:
	cmp (Enemy ptr [esi]).isExist, 0
	je post
	cmp dl, byte ptr (Enemy ptr [esi]).co.x  
	je check
	jmp over
check:
	cmp dh, byte ptr (Enemy ptr [esi]).co.y
	jne over
	mov (Enemy ptr [esi]).isExist, 0
	mov (bullet ptr [edi]).isExist, 0
	
	mov dl, byte ptr (bullet ptr [edi]).co.x
	mov dh, byte ptr (bullet ptr [edi]).co.y
	call gotoxy
	mov al, 32
	call writechar
	mov dl, byte ptr (Enemy ptr [edi]).co.x
	mov dh, byte ptr (Enemy ptr [edi]).co.y
	call gotoxy
	mov al, 32
	call writechar

	invoke deltaOfBulletNum, -1
	invoke deltaOfEnemyNum, -1
	invoke deltaOfScore, 100
	mov ebx, 1
	jmp quLa
post:
	inc ecx
over:
	add esi, type Enemy
	loop L
quLa:	
	ret
bulletCollision endp
end