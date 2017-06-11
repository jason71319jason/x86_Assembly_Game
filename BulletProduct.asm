INCLUDE lib.inc

.code
FindEmptySpace proto, bulletSetPtr:ptr bullet
BulletProduct proto, delx:sbyte, dely:sbyte, PrePosi:coord
BulletProductSet proc uses eax ebx ecx edx esi,
	bulletSetPtr:ptr bullet,
	canonType:byte,
	PlayerPosi:coord
	
	local tmpCoord:coord
	
	mov esi, bulletSetPtr
	.IF canonType == 1
		jmp oneCanon
	.ENDIF
	.IF canonType == 2
		jmp twoCanon
	.ENDIF
	.IF canonType == 3
		jmp threeCanon
	.ENDIF
	
oneCanon:
	invoke FindEmptySpace, esi
	invoke BulletProduct, 0, -1, PlayerPosi
	jmp Lo
twoCanon:
	mov ax ,PlayerPosi.x
	mov bx, PlayerPosi.y
	mov tmpCoord.x, ax
	mov tmpCoord.y, bx
	inc tmpCoord.x
	invoke FindEmptySpace, esi
	invoke BulletProduct, 0, -1, tmpCoord 
	sub tmpCoord.x, 2
	invoke FindEmptySpace, esi
	invoke BulletProduct, 0, -1, tmpCoord
	jmp Lo
threeCanon:
	mov ax ,PlayerPosi.x
	mov bx, PlayerPosi.y
	mov tmpCoord.x, ax
	mov tmpCoord.y, bx
	dec tmpCoord.x
	invoke FindEmptySpace, esi
	invoke BulletProduct, -1, -1, tmpCoord
	inc tmpCoord.x
	invoke FindEmptySpace, esi
	invoke BulletProduct, 0, -1, tmpCoord
	inc tmpCoord.x
	invoke FindEmptySpace, esi
	invoke BulletProduct, 1, -1, tmpCoord
Lo:
	ret
BulletProductSet endp

FindEmptySpace proc,
	bulletSetPtr:ptr bullet
	mov esi, bulletSetPtr
	mov ecx, 1000
L:
	cmp (bullet ptr [esi]).isExist, 0
	je over
	add esi, type bullet
	loop L
over:
	ret
FindEmptySpace endp

BulletProduct proc uses eax ebx esi,
	delx:sbyte,
	dely:sbyte,
	PrePosi:coord

	mov (bullet ptr [esi]).isExist, 1
	
	mov al, delx
	mov ah, dely
	mov (bullet ptr [esi]).deltaX, al 
	mov (bullet ptr [esi]).deltaY, ah
	
	mov ax, PrePosi.x
	mov bx, PrePosi.y
	add ax, word ptr (bullet ptr [esi]).deltaX
	add bx, word ptr (bullet ptr [esi]).deltaY
	mov (bullet ptr [esi]).co.x, ax 
	mov (bullet ptr [esi]).co.y, bx
	
	invoke deltaOfBulletNum, 1
	
	ret
BulletProduct endp
end