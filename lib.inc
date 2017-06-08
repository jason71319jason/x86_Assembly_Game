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
Lbound 		EQU 2
Ubound 		EQU 5
Dbound 		EQU 33
playerIcon 	EQU 127
bulletIcon 	EQU 111
threeBulletState EQU 4 

Enemy struct
	co Coord <?,?>
	typ byte 65

Enemy ends

Player struct
	co Coord <?,?>
	bulletType byte 1
	blood byte 3
	
Player ends

Bullet struct
	co Coord <0,5>
Bullet ends

printEnemy proto, enemySetPtr: ptr Enemy, num:dword

moveEnemy proto, enemySetPtr: ptr Enemy, num:dword

threadOfEnemy proto

strategyProduct proto, enemySetPtr:ptr Enemy, num:dword, start:byte

deltaOfEnemy proto, delta:dword

setOutputHandle proto, outputHandle:dword

threadOfStart proto

threadOfRule proto

threadOfPlayer proto

setState proto, newState:byte

getState proto

gameStateManage proto

playerInit proto, cord:coord

playerMove proto, playerPos:coord

playerDraw proto, setPtr: ptr Bullet, playerPos:coord, BulletSize:dword, num:byte

playerShooting proto, playerPos:coord, setPtr:ptr bullet, BulletSize:dword, num:byte