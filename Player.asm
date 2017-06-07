
INCLUDE lib.inc

.data

startPos coord <10,10>
bulletSet Bullet 1000 DUP(<>)
bulletNum byte 3

.code

threadOfPlayer proc
	call Clrscr
	INVOKE playerInit,
		startPos

	INVOKE playerAction,
		startPos,
		ADDR bulletSet,
		lengthof bulletSet,
		bulletNum
		
	call WaitMsg
	ret
threadOfPlayer	endp

end
