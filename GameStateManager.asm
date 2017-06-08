TITLE Final_Project_Main           

include lib.inc

.data 
	state byte 0
.code
	
gameStateManage proc uses eax ebx ecx edx esi,

Lstart:
	invoke threadOfStart	
	cmp ax, 28
	je LGame
	cmp ax, 36
	je LExit
	jmp LRule
LGame:
	invoke threadOfPlayer
	jmp Post
LRule:
	invoke threadOfRule
	jmp Lstart
Post:
LExit:
	ret

gameStateManage endp

getState proc
	mov al, state
	ret
getState endp
	
setState proc,
	newState:byte
	mov al, newState
	mov state, al
	ret
setState endp

end
