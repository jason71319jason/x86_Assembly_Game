INCLUDE lib.inc
	
.data

enemyNum sdword 0
enemySet Enemy 300 dup(<,,,,>)
start byte 0
counter dword 0
oh dword 0
.code	

threadOfEnemy proc uses eax ebx ecx edx esi,

	mov ecx, 10
L:
	.IF start == 0
	jmp product
	.ENDIF
	
	invoke printEnemy, addr enemySet, enemyNum
	cmp counter, 500
	jne reprint
product:	
	invoke strategyProduct, addr enemySet, enemyNum, start
	invoke moveEnemy, addr enemySet, enemyNum
	mov counter, 0
reprint:
	mov eax, 250
	add counter, eax
	call delay
	
	.IF start == 0
		mov start, 1
	.ENDIF
	loop L

	ret
	
threadOfEnemy endp
	
deltaOfEnemy proc uses eax ebx ecx edx esi,
	delta:dword
	
	mov eax, delta
	add enemyNum, eax
	cmp enemyNum, 0
	jnl nonZero
	mov enemyNum, 0

nonZero:	
	ret
	
deltaOfEnemy endp

setOutputHandle proc uses eax ebx ecx edx esi,
	outputHandle:dword
	
	mov eax, outputHandle
	mov oh, eax
	
	ret
setOutputHandle endp
end 