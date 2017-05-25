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

productEnemy proto, enemySetPtr: ptr Enemy, num:dword

moveEnemy proto, enemySetPtr: ptr Enemy, num:dword

deltaOfEnemy proto, delta:dword

threadOfEnemy proto
