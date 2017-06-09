INCLUDE lib.inc
	
.data

enemyNum sdword 0
enemySet Enemy 1000 dup(<,>)
start byte 0

.code	

threadOfEnemy proc uses eax ebx ecx edx esi,

	.IF start == 0
	jmp product
	.ENDIF
	
	invoke printEnemy, addr enemySet, enemyNum
product:	

	invoke strategyProduct, addr enemySet, enemyNum, start
	
	.IF start == 0
		mov start, 1
		invoke printEnemy, addr enemySet, enemyNum
	.ENDIF

	ret
	
threadOfEnemy endp
	
deltaOfEnemy proc uses eax ebx ecx edx esi,
	delta:dword
	
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
	mov dl, byte ptr(Enemy ptr [esi]).co.y
	mov dh, byte ptr(Enemy ptr [esi]).co.x
	call gotoxy
	mov eax, 240
	call setTextColor
	mov ax, 32
	call writechar
	add esi, type Enemy
	loop clean
	
	mov ecx, num
	mov esi, enemySetPtr
	
printLoop:
	add byte ptr(Enemy ptr [esi]).co.x, 1
	mov dl, byte ptr (Enemy ptr [esi]).co.y
	mov dh, byte ptr (Enemy ptr [esi]).co.x
	call Gotoxy
	mov eax, 240
	call setTextColor
	mov al, byte ptr (Enemy ptr [esi]).typ
	call WriteChar
	add esi, type Enemy
	loop printLoop
	ret
	
printEnemy endp


end 