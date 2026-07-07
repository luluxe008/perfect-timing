extends Node2D

@onready var inner : MeshInstance2D= $inner
@onready var outer : MeshInstance2D = $outer
@onready var timer : Timer = $Timer
@onready var animation : AnimationPlayer = $AnimationPlayer

@export var fire_on_ready := false
@export var wait_time : float = 5.0


# Is the QTE running?
var running := false

var tween: Tween

signal QTE_sucess(float)
signal QTE_failure

# Fire the QTE
# (ça commence l'animation et ça prend en compte les appuie)
func fire_QTE() -> void:

	running = true
	tween = get_tree().create_tween()
	tween.tween_property(outer, "scale", Vector2(1, 1), timer.wait_time)
	timer.start()
	
	



func cancel_QTE() -> void:
	running = false
	timer.stop()


func _failure() -> void:
	QTE_failure.emit()
	animation.play("failure")
	
	print("QTE FAILURE")
	running = false
	
func _sucess() -> void:
	QTE_sucess.emit()
	animation.play("sucess")
	print("QTE SUCESS")
	running = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = wait_time
	if fire_on_ready:
		fire_QTE()


func _physics_process(_delta: float) -> void:
	if running:
		if timer.time_left > 0:
			if Input.is_action_just_pressed("ui_accept"):
				_sucess()
		else:
			_failure()
