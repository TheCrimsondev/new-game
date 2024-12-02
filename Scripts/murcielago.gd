extends Node2D

class_name Murcielago

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var murcielago: Area2D = $"."

var vida = 1
const SPEED = 60.0
var direccion = 1

@export var flipped = false

func _ready():
	if flipped != false:
		direccion *= -1
		animated_sprite_2d.flip_h = not animated_sprite_2d.flip_h

#Señales
func _on_timer_timeout() -> void:
	#print("Timer")
	direccion *= -1
	animated_sprite_2d.flip_h = not animated_sprite_2d.flip_h

func _on_body_entered(body: Node2D) -> void:
	var detecion = murcielago.get_overlapping_bodies()
	for objeto in detecion:
		if objeto is Player:
			print("Bat hits player")
			objeto.Daño()


#Funciones
func _process(delta):
	position.x += SPEED	* delta * direccion
	
func Daño():
	queue_free()
