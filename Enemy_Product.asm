TITLE Final_Project_Main           

INCLUDE lib.inc


productEnemy proto,	locPtr: ptr Enemy, num:dword, bornLoc:byte
productEnemySet proto, enemySetPtr: ptr Enemy, num:dword, setPtr:ptr byte
randomOffset proto
randomType proto
.data 
	
	vType			byte	"0000110000",
							"0001001000",
							"0010000100",
							"0100000010",
							"1000000001",0
							
	waveType		byte	"1010101010",
							"0101010100",0
							
	pyramindType	byte	"1010101010",
							"0101010100",
							"0010101000",
							"0001010000",
							"0000100000",0
							
	triangleType	byte	"1111111110",
							"0100000100",
							"0010001000",
							"0001010000",
							"0000100000",0
							
	circleType		byte	"0001111000",
							"0110000110",
							"1100000011",
							"1000000001",
							"1100000011",
							"0110000110",
							"0001111000",0
	
	typeLoc dword 0
	locOffset dword 0
.code 

productEnemy proc uses eax ebx ecx edx esi,
	locPtr:ptr Enemy,
	num:dword,
	bornLoc:byte
	
	mov esi,locPtr
	mov ecx, 1000
findEmptyEnemy:
	mov al ,(Enemy ptr [esi]).isExist
	cmp al, 0
	je product
	add esi, type Enemy
	loop findEmptyEnemy
product:
	mov byte ptr (Enemy ptr [esi]).co.y, (Ubound)
	mov bl, bornLoc
	add ebx, locOffset
	add ebx, 3
	mov byte ptr (Enemy ptr [esi]).co.x, bl 
	mov byte ptr (Enemy ptr [esi]).isExist, 1 
	invoke deltaOfEnemy, 1
	
	ret
	
productEnemy endp

productEnemySet proc uses eax ebx ecx edx edi esi,
	enemySetPtr:ptr Enemy,
	num:dword,
	setPtr:ptr byte
	
	mov edi, enemySetPtr
	
	mov ecx, 0
	mov esi, setPtr

load:
	mov al, byte ptr [esi]
	cmp al, 0
	je	productType 
	
do:
	cmp al, 31h
	jne postDo
	
product:
	invoke productEnemy, edi, num, cl

postDo:

	inc ecx
	inc esi
	cmp ecx, 10
	je exitLabel
	jmp load
	
productType:
	invoke randomOffset
	invoke randomType
	ret
	
exitLabel:
	mov typeLoc, esi
	ret
productEnemySet endp

strategyProduct proc uses eax ebx ecx edx esi,
	enemySetPtr:ptr Enemy,
	num:dword,
	start:byte
	
	mov esi, enemySetPtr
	
	.IF start == 0
		;invoke randomOffset
		invoke randomType
	.ENDIF
	
	invoke productEnemySet, esi, num, typeLoc
	ret
strategyProduct endp

randomOffset proc uses eax ebx ecx edx esi,

	call Randomize
	mov eax, 6
	call RandomRange
	mov edx, 10
	mul edx
	mov locOffset, eax
	ret
	
randomOffset endp

randomType proc uses eax ebx ecx edx esi,

	call Randomize
	mov eax, 5
	call RandomRange
	
	cmp eax, 0
	je L1
	cmp eax, 1
	je L2
	cmp eax, 2
	je L3
	cmp eax, 3
	je L4
	cmp eax, 4
	je L5

L1:
	mov typeLoc, offset vType
	jmp exitL
L2:
	mov typeLoc, offset triangleType
	jmp exitL
L3:
	mov typeLoc, offset circleType
	jmp exitL
L4:
	mov typeLoc, offset pyramindType
	jmp exitL
L5:
	mov typeLoc, offset waveType
	jmp exitL

exitL:
	ret
	
randomType endp
	
end