TITLE Final_Project_Main           
include lib.inc

	heartGraphWidth		EQU 8
	heartGraphHeight	EQU 4
	screenWidth 		EQU 76
	screenHeight 		EQU 35
	bloodGraphWidth		EQU 20
	bloodGraphHeight	EQU	3
.data
	
	heartNum	dword 3
	boxPos 		coord <2,2>
	heartGraphPos	coord <30,38>
	bloodgraphPos	coord <7,39>
	boxTop		byte (screenWidth) dup ("_")
	boxBody		byte "|", (screenWidth-2) dup (32), "|"
	boxBottom	byte "|_", (screenWidth-4) dup ("_"),"_|"
	heartGraph	byte"  _  _  ",
					" / \/ \ ",
					" \    / ",
					"  \__/  ",0
	bloodGraph	byte" _      _   _   _   ",
					"|_) |  / \ / \ | \ o",
					"|_) |_ \_/ \_/ |_/ o",0
				
.code
	
printBox proc

	mov esi, offset boxTop
	mov dl, byte ptr boxPos.x
	mov dh, byte ptr boxPos.y
	mov eax, 240
	call setTextColor
	mov al, byte ptr [esi]
	mov ecx, screenWidth
Lt1:
	call gotoxy
	call writechar
	inc esi
	inc dl
	loop Lt1
	inc dh
	mov dl, byte ptr boxPos.x
	
	mov ecx, (screenHeight -2)
	mov esi, offset boxBody
L1:
	push ecx
	mov ecx, screenWidth
L2:
	call gotoxy
	mov al, byte ptr [esi]
	call writechar
	inc dl
	inc esi
	loop L2
	mov dl, byte ptr boxPos.x
	inc dh
	mov esi, offset boxBody
	pop ecx
	loop L1
	
	mov esi, offset boxBottom
	mov ecx, screenWidth
Lb1:
	call gotoxy
	mov al, byte ptr [esi]
	call writechar
	inc dl
	inc esi
	loop Lb1
	ret
printBox endp
	
printHeart proc
	mov esi, offset heartGraph
	mov ecx, heartNum
	mov dl, byte ptr heartGraphPos.x
	mov bl, byte ptr heartGraphPos.x
	mov dh, byte ptr heartGraphPos.y
	mov eax, 240
	call setTextColor
L1:
	push ecx
	mov ecx, heartGraphHeight
L2:
	push ecx
	mov ecx, heartGraphWidth
L3:	
	call gotoxy
	mov al, byte ptr [esi]
	call writechar
	inc dl
	inc esi
	loop L3
	pop ecx
	mov dl, bl
	inc dh
	loop L2
	pop ecx
	mov dh, byte ptr heartGraphPos.y
	add bl, heartGraphWidth
	mov dl, bl
	mov esi, offset heartGraph
	loop L1
	ret
printHeart endp

printBlood proc
	mov esi, offset bloodGraph
	mov dl, byte ptr bloodgraphPos.x
	mov dh, byte ptr bloodgraphPos.y
	mov eax, 240
	call setTextColor
	mov ecx, bloodGraphHeight
L1:
	push ecx
	mov ecx, bloodGraphWidth
L2:
	call gotoxy
	mov al, byte ptr [esi]
	call writechar
	inc dl
	inc esi
	loop L2
	inc dh
	mov dl, byte ptr bloodgraphPos.x
	pop ecx
	loop L1
	ret
printBlood endp
end
