extends CharacterBody2D
class_name Player


const SPEED = 120.0
const JUMP_VELOCITY = -260.0

#@onready var personaje: Player = get_owner()
#@onready var animation_tree: AnimationTree = $AnimationTree

@onready var animacion = $AnimatedSprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Attack"):
		animacion.play("Attack01")
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animacion.play("Saltar")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	#print(direction)


	#Sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	#Movimiento
	if direction > 0:
		velocity.x = direction * SPEED
	elif direction < 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#Animaciones
	if direction != 0:
		animacion.play("Correr")
	else:
		if not animacion.is_playing():
			animacion.play("Idle")


	move_and_slide()


func Ataque():
	var cuerpos = $Area2D.get_overlapping_bodies()
	for cuerpo in cuerpos:
		if cuerpo is Enemigo:
			cuerpo.Daño(1)
			print("Daño a enemigo")
		if cuerpo is Murcielago:
			cuerpo.Daño()
			print("Daño a murcielago")

func _on_animated_sprite_2d_frame_changed() -> void:
	if animacion.animation == "Attack01":
		if animacion.frame == 3:
			Ataque()
		await animacion.animation_finished
		animacion.play("Idle")

func Daño():
	print("Jugador dañado")
