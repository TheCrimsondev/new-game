extends CharacterBody2D

class_name Enemigo

@onready var animacion = $AnimatedSprite2D

var vida = 3
var ir_izquierda = true

const SPEED = 40.0
const JUMP_VELOCITY = -400.0

func _on_timer_timeout() -> void:
	ir_izquierda = !ir_izquierda

func _physics_process(delta: float) -> void:
	var direccion
	
	if ir_izquierda:
		direccion = Vector2.LEFT
	else:
		direccion = Vector2.RIGHT

	if direccion:
		velocity = direccion * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func Daño(valor_daño : int):
	vida -= valor_daño
	if (vida <= 0):
		Muere()

func Muere():
	animacion.play("Muere")
	await animacion.animation_finished
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	animacion.play("Attack01")

func _on_animated_sprite_2d_frame_changed() -> void:
	if animacion != null:
		if animacion.animation == "Attack01":
			if animacion.frame == 3:
				Ataque()
			await animacion.animation_finished
			animacion.play("Idle")

func Ataque():
	var cuerpos = $Area2D.get_overlapping_bodies()
	for cuerpo in cuerpos:
		if cuerpo is Jugador:
			cuerpo.Daño()
		
