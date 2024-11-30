extends CharacterBody2D
class_name Jugador


const SPEED = 120.0
const JUMP_VELOCITY = -240.0

@onready var animacion = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Attack"):
		animacion.play("Attack01")
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func Ataque():
	var cuerpos = $Area2D.get_overlapping_bodies()
	for cuerpo in cuerpos:
		if cuerpo is Enemigo:
			cuerpo.Daño()

func _on_animated_sprite_2d_frame_changed() -> void:
	if animacion.animation == "Attack01":
		if animacion.frame == 3:
			Ataque()
		await animacion.animation_finished
		animacion.play("Idle")
