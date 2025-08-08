extends Interactable

@onready var animation_player: AnimationPlayer = get_node(^"../../../AnimationPlayer")
@onready var indicator_off: MeshInstance3D = get_node(^"../../OFF")
@onready var indicator_on: MeshInstance3D = get_node(^"../../ON")

var is_pressed: bool = false
var state: bool = false

func _ready() -> void:
	indicator_off.mesh = indicator_off.mesh.duplicate(true)
	indicator_on.mesh = indicator_on.mesh.duplicate(true)

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
