extends VBoxContainer

var children: Array[Node] = []
var label



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		add_label("text")
		

func add_label(text):
	if len(children) >= 4:
		children.remove_at(0)
		children[0].queue_free()
	label = Label.new()
	label.text = text
	children.append(label)
	add_child(children[-1])
	
