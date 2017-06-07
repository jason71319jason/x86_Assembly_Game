include Irvine32.inc

ExitState	EQU 0
StartState 	EQU 1
RuleState	EQU 2
GameState	EQU 3

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

threadOfStart proto

threadOfRule proto

setState proto, newState:byte

getState proto

gameStateManage proto