INCLUDE Irvine32.inc
INCLUDE Player.inc
.code
Init PROC USES eax edx ecx,
		playerX2: byte,
		playerY2: byte,
		playerPosition: word,
		bulletLocationX3: PTR DWORD,
		bulletLocationY3: PTR DWORD,
		BulletLength4: DWORD
	mov ecx, BulletLength4
	mov esi, bulletLocationX3
	mov edi, bulletLocationY3
InitBullet:
	mov byte PTR[esi], 0
	mov byte PTR[edi], 5
	inc esi
	inc edi
	loop InitBullet
	call Clrscr
	mov dh, playerY2
	mov dl, playerX2 
	call Gotoxy
	mov ax, playerPosition
	call WriteChar
	ret
Init endp
end