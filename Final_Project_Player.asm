INCLUDE Irvine32.inc
Shooting proto,
		playerX: byte,
		playerY: byte,
		BulletPositionX2: PTR DWORD,
		BulletPositionY2: PTR DWORD,
		BulletLength: DWORD
Draw proto,
		bulletLocationX: PTR DWORD,
		bulletLocationY: PTR DWORD,
		playerX3: byte,
		playerY3: byte,
		playerPosition2: word,
		BulletLength2: DWORD,
		bulletPosition: word
Init proto,
		playerX2: byte,
		playerY2: byte,
		playerPosition: word
Action proto,
		playerX4: byte,
		playerY4: byte,
		bulletLocationX2: PTR DWORD,
		bulletLocationY2: PTR DWORD,
		playerPosition3: word,
		BulletLength3: DWORD,
		bulletPosition2: word
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
		bullet
		
	call WaitMsg

main endp

end main
