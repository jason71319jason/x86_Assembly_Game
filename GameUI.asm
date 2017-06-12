TITLE Final_Project_Main           
include lib.inc

	heartGraphWidth		EQU 8
	heartGraphHeight	EQU 4
	screenWidth 		EQU 76
	screenHeight 		EQU 32
	bloodGraphWidth		EQU 20
	bloodGraphHeight	EQU	3
	levelGraphWidth		EQU 22
	levelGraphHeight	EQU	3
	numGraphWidth		EQU 4
	numGraphHeight	    EQU	3
.data
	
	level		dword 1
	heartNum	dword 5
	boxPos 		coord <2,4>
	heartGraphPos	coord <28,37>
	bloodgraphPos	coord <5,38>
	levelGraphPos	coord <20,0>
	levelNumPos     coord <44,0>
	boxTop		byte (screenWidth) dup ("#")
	boxBody		byte "|", (screenWidth-2) dup (32), "|"
	boxBottom	byte "^", (screenWidth-2) dup (94),"^"
	heartGraph	byte"  _  _  ",
					" / \/ \ ",
					" \    / ",
					"  \__/  ",0
	bloodGraph	byte" _      _   _   _   ",
					"|_) |  / \ / \ | \ o",
					"|_) |_ \_/ \_/ |_/ o",0
	levelGraph	byte"_    __       __ _    ",
					"|   |__ \  / |__ |   o",
					"|__ |__  \/  |__ |__ o",0
	num1Graph	byte"  | ",
					"  | ",
					"  | ",0
	num2Graph	byte" __ ",
					" __|",
					"|__ ",0
	num3Graph	byte" __ ",
					" __|",
					" __|",0
	num4Graph	byte" /| ",
					"/_|_",
					"  | " ,0
	num5Graph	byte" __ ",
					"|__ ",
					" __|",0
	num6Graph	byte" __ ",
					"|__ ",
					"|__|",0
	num7Graph	byte" __ ",
					"|  |",
					"   |",0
	num8Graph	byte" __ ",
					"|__|",
					"|__|",0
	num9Graph	byte" __ ",
					"|__|",
					" __|",0
	num0Graph	byte" __ ",
					"|  |",
					"|__|",0

.code
	
printBox proc uses eax ebx ecx edx edi esi,

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
	
printHeart proc uses eax ebx ecx edx edi esi,
	
	mov dl, byte ptr heartGraphPos.x	
	mov dh, byte ptr heartGraphPos.y
	mov ecx, heartGraphHeight
clean:
	push ecx
	mov ecx, heartGraphWidth
	add ecx, heartGraphWidth
	add ecx, heartGraphWidth
	add ecx, heartGraphWidth
	add ecx, heartGraphWidth	
clean2:
	call gotoxy
	mov al, 32
	call writechar
	inc dl
	loop clean2
	pop ecx
	mov dl, byte ptr heartGraphPos.x	
	inc dh
	loop clean
	cmp heartNum, 0
	je checkdead
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
	jmp exitL
checkdead:
	invoke setState, FinishState
exitL:
	ret
printHeart endp

printBlood proc uses eax ebx ecx edx edi esi,

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

printLevel proc uses eax ebx ecx edx edi esi,

	mov esi, offset levelGraph
	mov dl, byte ptr levelgraphPos.x
	mov dh, byte ptr levelgraphPos.y
	mov eax, 240
	call setTextColor
	mov ecx, levelGraphHeight
L1:
	push ecx
	mov ecx, levelGraphWidth
L2:
	call gotoxy
	mov al, byte ptr [esi]
	call writechar
	inc dl
	inc esi
	loop L2
	inc dh
	mov dl, byte ptr levelgraphPos.x
	pop ecx
	loop L1
	ret
printLevel endp

deltaOfHeart proc uses eax,
	delta:sdword
	mov eax, delta
	add heartNum, eax
	cmp heartNum, 0
	jnl nonZero
	mov heartNum, 0

nonZero:
	invoke printHeart
	ret
deltaOfHeart endp

printLevelNum proc uses eax ebx ecx edx edi esi,
	
	mov ecx, 9
	mov esi, offset num9Graph
	mov dl, byte ptr levelNumPos.x
	mov dh, byte ptr levelNumPos.y

compare:
	cmp ecx, level
	je print3
	sub esi, 13
loop compare

print3:
	mov ecx, numGraphHeight
print:
	push ecx
	mov ecx, numGraphWidth
print2:		
	call gotoxy
	mov al, byte ptr [esi]
	call writechar
	inc dl
	inc esi
	loop print2
	inc dh
	mov dl, byte ptr levelNumPos.x
	pop ecx
	loop print
	
	cmp level, 9
	je exitL
	add level, 1
exitL:
	ret
printLevelNum endp
end
