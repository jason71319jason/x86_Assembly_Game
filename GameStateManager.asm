TITLE Final_Project_Main           

include lib.inc
	
.data 
	state byte 0
	startPos coord <38,33>
	counter dword 0
	enemyCall dword 1000
	benchmark dword 2000
	toolbenchmark dword 499
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
	invoke threadOfEnemy
ThreadLoop:

PlayerThread:
	invoke threadOfPlayer
	
	invoke getScore
	.IF eax > toolbenchmark
	invoke toolProduct
	add toolbenchmark, eax
	.ENDIF

EnemyThread:

	mov eax, enemyCall
	cmp counter, eax
	jne postDo
	invoke threadOfEnemy
postDo:
	mov eax, 20
	call delay
	add counter, eax
	mov eax, enemyCall
	.IF counter > eax
		sub counter, eax
	.ENDIF	
	
	sub benchmark, 20
	cmp benchmark, 0
	je levelUp
	
	cmp state, GameState
	je ThreadLoop
	jmp post
levelUp:
	mov benchmark, 2000
	sub enemyCall, 100
	cmp enemyCall, 0
	jne nonzero
	mov enemyCall, 50
	jmp ThreadLoop
nonzero:
	invoke printLevelNum
	jmp ThreadLoop
	
	jmp Post
LRule:
	call Clrscr
	invoke setState, RuleState
	invoke threadOfRule
	jmp Post
LFinish:
	call Clrscr
	invoke setState, FinishState
	invoke printScore

	jmp LExit
Post:
	mov al, state
	cmp al, StartState
	je Lstart
	cmp al, RuleState
	je LRule
	cmp al, GameState
	je LGame
	cmp al, ExitState
	je LExit
	cmp al, FinishState
	je LFinish
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
	invoke printBlood
	invoke printLevel
	invoke printLevelNum
	invoke printBox
	invoke playerInit, startPos
	ret
gameInit endp

setEnemyCall proc uses eax,
	num:dword
	mov eax, num
	mov enemyCall, eax
	ret
setEnemyCall endp
end
