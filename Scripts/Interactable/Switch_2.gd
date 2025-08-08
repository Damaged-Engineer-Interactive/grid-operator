extends Interactable

@onready var animation_player: AnimationPlayer = get_node(^"../../AnimationPlayer")
@onready var text_o: MeshInstance3D = get_node(^"../../Text_O")
@onready var text_i: MeshInstance3D = get_node(^"../../Text_I")

var is_pressed: bool = false
var state: bool = false

func _ready() -> void:
	text_o.mesh = text_o.mesh.duplicate(true)
	text_i.mesh = text_i.mesh.duplicate(true)

func primary_text() -> String:
	return "Switch"

func primary():
	if is_pressed:
		return
	is_pressed = true
	state = not state
	if state:
		animation_player.play(&"switch")
	else:
		animation_player.play_backwards(&"switch")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	is_pressed = false
