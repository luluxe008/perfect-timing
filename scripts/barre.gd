extends Node2D
var speed = 10
var direction = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $curseur.position.x < -50:
		direction = 1
	if $curseur.position.x > 50:
		direction = -1
	$curseur.position.x += speed * delta * direction
	
	if Input.is_action_just_pressed("ui_accept"):
		if $curseur.position.x > 2*$zone.position.x and $curseur.position.x < -2*$zone.position.x:
			print("win")
		else:
			print("lose")
