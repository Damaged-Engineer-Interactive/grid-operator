extends Interactable

var is_door_open: bool = false
@export var open_reverse: bool = false

@onready var animation_player: AnimationPlayer = get_node(^"../../../../../AnimationPlayer")

func get_interaction_text():
	if is_door_open:
		return "close"
	return "open"

func interact():
	print("Interacted with door")
	
	if is_door_open:
		animation_player.play(&"close")
	else:
		animation_player.play(&"open")
	
	is_door_open = not is_door_open
