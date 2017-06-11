include Irvine32.inc

ExitState	EQU 0
StartState 	EQU 1
RuleState	EQU 2
GameState	EQU 3
right 		EQU 'd'
left 		EQU 'a'
up 			EQU 'w'
down 		EQU 's'
shoot 		EQU 'k'
Rbound 		EQU 76
Lbound 		EQU 3
Ubound 		EQU 5
Dbound 		EQU 34
playerIcon 	EQU 126
bulletIcon 	EQU 111
threeBulletState EQU 4 

Enemy struct
	co Coord <?,?>
	typ byte 64
	isExist byte 0
Enemy ends

Player struct
	co Coord <?,?>
	bulletType byte 1
	blood byte 3
	
Player ends

Bullet struct
	co Coord <?,?>
	deltaX sbyte 0
	deltaY sbyte 0
	isExist byte 0
Bullet ends

printEnemy proto, enemySetPtr: ptr Enemy, num:dword

threadOfEnemy proto

strategyProduct proto, enemySetPtr:ptr Enemy, num:dword, start:byte

deltaOfEnemy proto, delta:sdword

setOutputHandle proto, outputHandle:dword

threadOfStart proto

threadOfRule proto

threadOfPlayer proto

setState proto, newState:byte

getState proto

gameStateManage proto

playerInit proto, cord:coord

setShootState proto, x:byte

playerMove proto, playerPos:coord

LastBulletPosition proto, LastBulletPositionX:byte, LastBulletPositionY:byte, BulletState:DWORD

printBox proto,

printHeart proto,

printBlood proto,

gameInit proto,

deltaOfbulletNum proto, delta:sdword
	
setPlayerPos proto, newX:word, newY:word

BulletProductSet proto, bulletSetPtr:ptr bullet, canonType:byte, PlayerPosi:coord

BulletPrint proto, bulletSetPtr:ptr bullet, bulletNum:dword, playerPosi:coord

getEnemySet proto,

getEnemyNum proto,

deltaOfScore proto, delta:dword

getBulletSet proto

getBulletNum proto

printWave proto