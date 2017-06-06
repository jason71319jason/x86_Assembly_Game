TITLE Final_Project_Main           

INCLUDE lib.inc

.code 
moveEnemy proc uses eax ebx ecx edx esi,
	enemySetPtr:ptr Enemy,
	num:dword

	mov ecx, num
	mov esi, enemySetPtr
move:
	add byte ptr (Enemy ptr [esi]).co.x, 1
	add esi, type Enemy
	loop move
	
	ret
	
moveEnemy endp
end 