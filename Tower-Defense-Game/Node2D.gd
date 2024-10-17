extends Node2D

func _ready():
	$Campfire.play("burn")
	$"Campfire 2".play("Burn")
	$Tower.play("idle")
	$Tower/Tower.play("idle")
	$Flag.play("Wave")
	$Flag/Flag.play("Wave")
