extends Interactable

@onready var animation_player: AnimationPlayer = get_node(^"../../AnimationPlayer")
@onready var text_o: MeshInstance3D = get_node(^"../../Text_O")
@onready var text_i: MeshInstance3D = get_node(^"../../Text_I")
@onready var text_ii: MeshInstance3D = get_node(^"../../Text_II")

@onready var _module: SignalComponent = get_node(^"../..")

var is_pressed: bool = false
var is_pressed_internal: bool = false

var state: int = 0

@export var update_state_o: bool = false:
	set(_value):
		if is_pressed_internal:
			_module._set_state(0)

@export var update_state_i: bool = false:
	set(_value):
		if is_pressed_internal:
			_module._set_state(1)

@export var update_state_ii: bool = false:
	set(_value):
		if is_pressed_internal:
			_module._set_state(2)

func _ready() -> void:
	text_o.mesh = text_o.mesh.duplicate(true)
	text_i.mesh = text_i.mesh.duplicate(true)
	text_ii.mesh = text_ii.mesh.duplicate(true)

func primary_text() -> String:
	return "Switch left"

func secondary_text() -> String:
	return "Switch right"

func primary():
	if is_pressed or state == 2:
		return
	is_pressed = true
	is_pressed_internal = true
	state += 1
	match state:
		1:
			animation_player.play(&"O-I")
		2:
			animation_player.play(&"I-II")

func secondary():
	if is_pressed or state == 0:
		return
	is_pressed = true
	is_pressed_internal = true
	state -= 1
	match state:
		0:
			animation_player.play_backwards(&"O-I")
		1:
			animation_player.play_backwards(&"I-II")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	is_pressed = false
	is_pressed_internal = false

func _set_switch(_position: int) -> void:
	if _position == state:
		return
	elif _position not in range(0, 3):
		return
	while _position != state:
		match _position:
			0:
				animation_player.play(&"O-I")
				await animation_player.animation_finished
				state += 1
			1:
				if _position < state:
					animation_player.play_backwards(&"O-I")
					await animation_player.animation_finished
					state -= 1
				else:
					animation_player.play(&"I-II")
					await animation_player.animation_finished
					state += 1
			2:
				animation_player.play_backwards(&"I-II")
				await animation_player.animation_finished
				state -= 1
