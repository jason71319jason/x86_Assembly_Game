TITLE Final_Project_Main           
include lib.inc

.data 
	strPos 	coord <20,15>
	string 	byte "score: ",0
	msgExit	byte " press any key to quit.",0
.code
	
printScore proc
	
	mov dl, byte ptr strPos.x
	mov dh, byte ptr strPos.y
	call gotoxy
	mov edx, offset string
	call writeString
	add dl, 6
	invoke getScore
	call writeDec
	mov edx, offset msgExit
	call writeString
	call readchar
	ret
printScore endp

end
