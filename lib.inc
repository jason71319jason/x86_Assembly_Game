include Irvine32.inc


Coordinate struct
	x dword ?
	y dword ?

Coordinate ends

Enemy struct
	co Coordinate <?,?>
	typ byte 65
	sped byte ?
	damg byte ?
	blood byte ?

Enemy ends

printEnemy proto, enemySetPtr: ptr Enemy, num:dword

moveEnemy proto, enemySetPtr: ptr Enemy, num:dword

threadOfEnemy proto

strategyProduct proto, enemySetPtr:ptr Enemy, num:dword, start:byte

deltaOfEnemy proto, delta:dword

setOutputHandle proto, outputHandle:dword

threadOfPrint proto

