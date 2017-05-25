INCLUDE lib.inc
	
.data

enemyNum sdword 0
enemySet Enemy 20 dup(<,,,,>)

.code	

threadOfEnemy proc uses eax ebx ecx edx esi,

	mov ecx, 10
L:
	cmp enemyNum, 0
	je product
	invoke printEnemy, addr enemySet, enemyNum
product:	
	invoke productEnemy, addr enemySet, enemyNum

	invoke moveEnemy, addr enemySet, enemyNum
	mov eax, 1000
	call delay
	loop L

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

end 