extends Node2D

@onready var inner := $inner
@onready var outer : MeshInstance2D = $outer
@onready var timer := $Timer

@export var fire_on_ready := false
@export var wait_time : float = 5.0
		

# Is the QTE running?
var running := false

var sucessful_QTE := false
var tween

signal QTE_sucess
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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = wait_time
	if fire_on_ready:
		fire_QTE()


func _physics_process(_delta: float) -> void:
	if running:
		if timer.time_left > 0:
			if Input.is_action_just_pressed("ui_accept"):
				print(timer.time_left)
				sucessful_QTE = true
				QTE_sucess.emit()
				print("QTE SUCESS")
				running = false
		else:
			QTE_failure.emit()
			print("QTE FAILURE")
			running = false
			
