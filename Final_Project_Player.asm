INCLUDE Irvine32.inc
INCLUDE Player.inc
main     EQU start@0
.data
startY byte 43
startX byte 94
player word 127
bullet word 111
BulletPositionY byte 10000 DUP(?)
BulletPositionX byte 10000 DUP(?)
right byte 'd'
left byte 'a'
up byte 'w'
down byte 's'
shoot byte 'k'
Rbound byte 187
Lbound byte 0
Ubound byte 0
Dbound byte 43
BulletNum byte 3

.code

main proc

	INVOKE Init,
		startX,
		startY,
		player

	INVOKE Action,
		startX,
		startY,
		ADDR BulletPositionX,
		ADDR BulletPositionY,
		player,
		lengthof BulletPositionX,
		bullet,
		BulletNum
		
	call WaitMsg

main endp

end main
