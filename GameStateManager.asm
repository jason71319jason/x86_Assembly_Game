TITLE Final_Project_Main           

include lib.inc
	
.data 
	state byte 0
	startPos coord <38,33>
	counter dword 0

.code
	
gameStateManage proc uses eax ebx ecx edx esi,
	
Lstart:
	call Clrscr
	invoke setState, StartState
	invoke threadOfStart	
	cmp ax, 28
	je LGame
	cmp ax, 36
	je LExit
	jmp LRule
LGame:
	call Clrscr
	invoke setState, GameState
	invoke gameInit
ThreadLoop:
PlayerThread:
	invoke threadOfPlayer

EnemyThread:
	cmp counter, 200
	jne postDo
	invoke threadOfEnemy
postDo:
	mov eax, 20
	call delay
	add counter, eax
	.IF counter > 200
		sub counter, 200
	.ENDIF
	cmp state, GameState
	je ThreadLoop
	
	jmp Post
LRule:
	call Clrscr
	invoke setState, RuleState
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

gameInit proc
	invoke printHeart
	invoke printBox
	invoke printBlood
	invoke printWave
	invoke playerInit, startPos
	ret
gameInit endp

end
