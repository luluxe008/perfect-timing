extends Node2D

@export var moving := true
@export var speed = 5
var direction = 1

enum BarreZone{
	Perfect,
	Good,
	OK,
	Meh
}



signal barre_hit(BarreZone)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$cursor/VisibleOnScreenNotifier2D.connect("screen_exited", _on_visible_on_screen_notifier_2d_screen_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not moving:
		return
	$cursor.position.x += speed * direction
	
	if Input.is_action_just_pressed("ui_accept"):
		for area: Area2D in $cursor.get_overlapping_areas():
			if area.is_in_group("perfect"):
				barre_hit.emit(BarreZone.Perfect)
				print("PERFECT")
				return
			if area.is_in_group("good"):
				barre_hit.emit(BarreZone.Good)
				print("GOOD")
				return
			if area.is_in_group("ok"):
				barre_hit.emit(BarreZone.OK)
				print("OK")
				
				return
			if area.is_in_group("meh"):
				barre_hit.emit(BarreZone.Meh)
				print("MEH")
				return
			# no other case possible
		print("this is not possible :'(")
		push_error("player miss the whole zone? impossible")
			
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	direction *= -1
