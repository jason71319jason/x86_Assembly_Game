INCLUDE lib.inc
	

enemyCollision proto, enemyLoc:ptr enemy
.data

enemyNum sdword 0
enemySet Enemy 1500 dup(<,>)
start byte 0

.code	

threadOfEnemy proc uses eax ebx ecx edx esi,

	invoke strategyProduct, addr enemySet, enemyNum, start
	invoke printEnemy, addr enemySet, enemyNum	
	.IF start == 0
	mov start, 1
	.ENDIF
	ret
	
threadOfEnemy endp
	
deltaOfEnemyNum proc uses eax ebx ecx edx esi,
	delta:sdword
	
	mov eax, delta
	add enemyNum, eax
	cmp enemyNum, 0
	jnl nonZero
	mov enemyNum, 0

nonZero:	
	ret
	
deltaOfEnemyNum endp

printEnemy proc uses eax ebx ecx edx esi,
	enemySetPtr:ptr Enemy,
	num:dword
	
	mov eax, 240
	call setTextColor
	mov ecx, num
	mov esi, enemySetPtr
	
L:	
	cmp (Enemy ptr [esi]).isExist, 0
	je post
	mov dl, byte ptr (Enemy ptr [esi]).co.x
	mov dh, byte ptr (Enemy ptr [esi]).co.y
	
	invoke getPlayerPos
	cmp al, dl
	je check
	jmp clean
check:
	cmp bl, dh
	je hurt
	jmp clean
hurt:
	invoke deltaOfHeart, -1
	invoke deltaOfEnemyNum, -1
	mov (Enemy ptr [esi]).isExist, 0
	call gotoxy
	mov al, playerIcon
	call writechar
	jmp postDo
	
clean:

	invoke enemyCollision, esi
	cmp ebx, 1
	je postDo
	
	call gotoxy
	mov al, 32
	call writechar
move:
	inc dh
	mov byte ptr (Enemy ptr [esi]).co.y, dh
	invoke enemyCollision, esi	
		
	invoke getToolPos
	cmp ax, (Enemy ptr [esi]).co.x
	jne posCheck
	cmp bx, (Enemy ptr [esi]).co.y
	jne posCheck
	invoke cantUseToolKind
	
posCheck:
	.if dl > Rbound || dl < Lbound
	mov (Enemy ptr [esi]).isExist, 0
	invoke deltaOfHeart, -1
	invoke deltaOfEnemyNum, -1
	jmp postDo
	.endif
	
	.if dh > Dbound || dh < Ubound
	mov (Enemy ptr [esi]).isExist, 0
	invoke deltaOfHeart, -1
	invoke deltaOfEnemyNum, -1
	jmp postDo
	.endif
	
	cmp (Enemy ptr [esi]).isExist, 0
	je postDo
	call gotoxy
	mov al, EnemyIcon
	call writechar
	jmp postDo
post:
	inc ecx
postDo:
	add esi, type Enemy
	dec ecx
	cmp ecx, 0
	jne L
	
	ret
	
printEnemy endp

getEnemyNum proc
	mov eax, enemyNum
	ret
getEnemyNum endp

getEnemySet proc
	mov esi, offset enemySet
	ret
getEnemySet endp


enemyCollision proc uses ecx eax edx edi esi,
	enemyLoc:ptr Enemy
	
	mov ebx, 0
	mov edi, enemyLoc
	mov dl, byte ptr (bullet ptr [edi]).co.x
	mov dh, byte ptr (bullet ptr [edi]).co.y
	invoke getBulletSet
	invoke getBulletNum
	mov ecx, eax
L:
	cmp (bullet ptr [esi]).isExist, 0
	je post
	cmp dl, byte ptr (bullet ptr [esi]).co.x  
	je check
	jmp over
check:
	cmp dh, byte ptr (bullet ptr [esi]).co.y
	jne over
	mov (bullet ptr [esi]).isExist, 0
	mov (Enemy ptr [edi]).isExist, 0
	mov dl, byte ptr (Enemy ptr [edi]).co.x
	mov dh, byte ptr (Enemy ptr [edi]).co.y
	call gotoxy
	mov al, 32
	call writechar
	mov dl, byte ptr (bullet ptr [esi]).co.x
	mov dh, byte ptr (bullet ptr [esi]).co.y
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
	add esi, type bullet
	loop L
quLa:	
	ret
enemyCollision endp

end 