TITLE Final_Project_Main           

INCLUDE lib.inc
INCLUDE VirtualKeys.inc

	screenWidth 	EQU 80
	screenHeight 	EQU	45
	titleWidth 		EQU	33
	optionWidth 	EQU	20
	markWidth 		EQU	10
	Height 			EQU 3
	GraphWidth 		EQU 14
	GraphHeight 	EQU 12
	print proto, newCoord:coord, graphPtr:ptr byte, newHeight:dword, newWidth:dword
	setChoosen proto, direction:byte
.data

	titleStringPos	coord <23,7>
	optionStartPos	coord <30,27>
	optionExitPos	coord <30,35>
	optionRulePos	coord <30,31>
	choosenMarkPos	coord <17,32>
	graphPos		coord <32,13>
			 
	optionStart	byte	" __ ___  _   __  ___",
						"(__  |  /_\ |__)  | ",
						" __) | /   \|  \  | ",0
	optionRule	byte	"   __  _  __    __  ",
						"  |__) |  ||   |__  ",
						"  |  \ |__||__ |__  ",0
	optionExit	byte	"   __ _  _ ___ ___  ",
						"  |__  \/   |   |   ",
						"  |__ _/\_ _|_  |   ",0
	titleString	byte	" __  _ _  _   _  ___ ___ _  _  __" ,
						"(__  |_| / \ / \  |   |  |\ | / _" ,
						" __) | | \_/ \_/  |  _|_ | \| \_|",0
	graph		byte	"     _/\_     ",
						"   _/_/\_\_   ",
						"  //  ^^  \\  ",
						"  ||      ||  ",
						"  ||      ||  ",
						"  || <[]> ||  ",
						"  ||      ||  ",
						"  ||      ||  ",
						" //        \\ ",	
						"// \\_/\_// \\",
						"    []  []    ",
						"    ''  ''    ",0
	choosenMark	byte	"      |\  ",
						" =====| > ",
						"      |/  ",0
				
.code
    
threadOfStart proc uses ebx ecx edx esi,
	
	push ebp
	mov ebp, esp
	add esp, -4
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

	invoke print, titleStringPos, addr titleString, Height, titleWidth
	invoke print, optionExitPos, addr optionExit, Height, optionWidth
	invoke print, optionStartPos, addr optionStart, Height, optionWidth
	invoke print, optionRulePos, addr optionRule, Height, optionWidth
	invoke print, graphPos, addr graph, GraphHeight, GraphWidth
	
L:
	invoke print, choosenMarkPos, addr choosenMark, Height, markWidth
	call readchar
	mov byte ptr [esp-4], al
	cmp al, 'w'
	je UPs
	cmp al, 's'
	je DOWNs
	cmp al, 32
	je exitLabel
	jmp POST
UPs:
	invoke setChoosen, 1
	jmp POST
DOWNs:
	invoke setChoosen, 0
POST:
	mov eax, 20
	call delay
	loop L
exitLabel:
	mov esp, ebp
	pop ebp
	mov ax, choosenMarkPos.y
	ret
	
threadOfStart endp

print proc uses eax ebx ecx edx esi,
	newCoord:coord,
	graphPtr:ptr byte,
	newHeight:dword,
	newWidth:dword,
	
	mov esi, graphPtr
	mov ecx, newHeight
	mov dl, byte ptr newCoord.x
	mov dh, byte ptr newCoord.y
L1:
	push ecx
	mov ecx, newWidth
L2:
	call gotoxy
	mov eax, 240
	call setTextColor
	mov al, byte ptr [esi]
	call writechar
	inc esi
	inc dl
	loop L2
	pop ecx
	mov dl, byte ptr newCoord.x
	inc dh
	loop L1
	
	ret
print endp

setChoosen proc, direction:byte

	mov dh, byte ptr choosenMarkPos.y
	mov ecx, 3
L1:
	mov dl, byte ptr choosenMarkPos.x
	push ecx
	mov ecx, 10
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
	loop L1
	
	mov al, direction
	cmp al, 1
	je ups 
downs:
	mov ax, choosenMarkPos.y
	add ax, 4
	cmp ax, 36
	ja retrn
	mov choosenMarkPos.y, ax
	jmp retrn
ups:
	mov ax, choosenMarkPos.y
	sub ax, 4
	cmp ax, 27
	jb retrn
	mov choosenMarkPos.y, ax
retrn:
	ret
setChoosen endp

end
