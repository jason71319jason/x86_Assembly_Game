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
Lbound byte 2
Ubound byte 7
Dbound byte 43
BulletNum byte 1

.code

main proc
	INVOKE Init,
		startX,
		startY,
		player,
		ADDR BulletPositionX,
		ADDR BulletPositionY,
		lengthof BulletPositionX

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
