extends Area2D

@onready var label: Label = $Label
@onready var tesoro: Area2D = $"."

@export var texto = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = texto
	label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	var cuerpos = tesoro.get_overlapping_bodies()
	for cuerpo in cuerpos:
		if cuerpo is Player:
			label.visible = true
