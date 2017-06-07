
INCLUDE lib.inc
.code
playerInit PROC USES eax edx ecx,
		cord:coord,

	mov dh, byte ptr cord.y
	mov dl, byte ptr cord.x
	call Gotoxy
	mov ax, playerIcon
	call WriteChar
	ret
playerInit endp
end