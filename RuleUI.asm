TITLE Final_Project_Main           

include lib.inc

.data 
	descriptionStr byte "Description: Press W, S, A, D to control the spaceship. ",
						"             Press K to shot and Press SPACE to confirm.",
						"             Press ESC to quit.                         ",
						"                                                        ",
						"                                                --> BACK",0
	
	descriptionStrPos	coord <10,5>
.code
	threadofRule proc uses eax ebx ecx edx esi,
	
	call clrscr
	mov dl, 0
	mov dh, 0
	mov ecx, 45
L1:
	push ecx
	mov ecx, 80
L2:
	call gotoxy
	mov eax, 240
	call setTextColor
	mov al, 32
	call writechar
	inc dl
	loop L2
	pop ecx
	inc dh
	mov dl, 0
	loop L1
	
	mov esi, offset descriptionStr
	mov ecx, 5
	mov dl, byte ptr descriptionStrPos.x
	mov dh, byte ptr descriptionStrPos.y
L4:
	push ecx
	mov ecx, 56
L3:
	call gotoxy
	mov eax, 240
	call setTextColor
	mov al, byte ptr [esi]
	call writechar
	inc esi
	inc dl
	loop L3
	pop ecx
	mov dl, byte ptr descriptionStrPos.x
	inc dh
	loop L4
read:
	call readchar
	cmp al, 32
	jne read
	invoke setState, StartState
	ret
	threadofRule endp
end
