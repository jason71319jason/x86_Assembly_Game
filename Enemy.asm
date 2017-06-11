INCLUDE lib.inc
	

enemyCollision proto, enemyLoc:ptr enemy
.data

enemyNum sdword 0
enemySet Enemy 1000 dup(<,>)
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
	
deltaOfEnemy proc uses eax ebx ecx edx esi,
	delta:sdword
	
	mov eax, delta
	add enemyNum, eax
	cmp enemyNum, 0
	jnl nonZero
	mov enemyNum, 0

nonZero:	
	ret
	
deltaOfEnemy endp

printEnemy proc uses eax ebx ecx edx esi,
	enemySetPtr:ptr Enemy,
	num:dword
	
	mov eax, 0
	call setTextColor
	mov ecx, num
	mov esi, enemySetPtr
	
clean:
	cmp (Enemy ptr [esi]).isExist, 0
	je post
	
	mov dl, byte ptr(Enemy ptr [esi]).co.x
	mov dh, byte ptr(Enemy ptr [esi]).co.y	
	call gotoxy
	mov eax, 240
	call setTextColor
	mov ax, 32
	call writechar
	jmp postdo
post:
	inc ecx
postdo:
	add esi, type Enemy
	loop clean
	
	mov ecx, num
	mov esi, enemySetPtr
	
printLoop:
	cmp (Enemy ptr [esi]).isExist, 0
	je plPost
	add byte ptr(Enemy ptr [esi]).co.y, 1
	mov dl, byte ptr (Enemy ptr [esi]).co.x
	mov dh, byte ptr (Enemy ptr [esi]).co.y

	
	.if dl > Rbound || dl < Lbound
	mov (enemy ptr [esi]).isExist, 0
	invoke deltaOfEnemy, -1
	jmp plPostDo
	.endif
	
	.if dh > Dbound || dh < Ubound
	mov (enemy ptr [esi]).isExist, 0
	invoke deltaOfEnemy, -1
	jmp plPostDo
	.endif

	invoke enemyCollision, esi

print:
	cmp (Enemy ptr [esi]).isExist, 0
	je plPost	
	call Gotoxy
	mov eax, 240
	call setTextColor
	mov al, byte ptr (Enemy ptr [esi]).typ
	call WriteChar
	jmp plPostDo
plPost:
	inc ecx
plPostDo:
	add esi, type Enemy
	loop printLoop
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
	mov al, 33
	call writechar
	mov dl, byte ptr (bullet ptr [esi]).co.x
	mov dh, byte ptr (bullet ptr [esi]).co.y
	call gotoxy
	mov al, 33
	call writechar
	invoke deltaOfBulletNum, -1
	invoke deltaOfEnemy, -1
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