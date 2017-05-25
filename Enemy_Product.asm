TITLE Final_Project_Main           

INCLUDE lib.inc

.code 

productEnemy proc uses eax ebx ecx edx esi,
	enemySetPtr:ptr Enemy,
	num:dword

	mov esi, enemySetPtr
	mov eax, num
	mov ebx, type Enemy
	mul ebx
	add esi, eax
	mov (Enemy ptr [esi]).co.x, 0
	call Randomize
	mov eax, 10
	call RandomRange
	mov byte ptr (Enemy ptr [esi]).co.y, al
	invoke deltaOfEnemy, 1
	
	ret
	
productEnemy endp

end