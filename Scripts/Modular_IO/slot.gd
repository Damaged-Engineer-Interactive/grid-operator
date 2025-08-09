extends SignalComponent

enum COLORS { WHITE = 0, RED, ORANGE, YELLOW, GREEN, CYAN, BLUE, PURPLE, PINK, MAX } # MAX is not valid

const DIMM_MATERIAL_MAP: Dictionary[COLORS, StandardMaterial3D] = {
	COLORS.WHITE: preload("res://Assets/Materials/Slot/Dimm/white_dimm.material"),
	COLORS.RED: preload("res://Assets/Materials/Slot/Dimm/red_dimm.material"),
	COLORS.ORANGE: preload("res://Assets/Materials/Slot/Dimm/orange_dimm.material"),
	COLORS.YELLOW: preload("res://Assets/Materials/Slot/Dimm/yellow_dimm.material"),
	COLORS.GREEN: preload("res://Assets/Materials/Slot/Dimm/green_dimm.material"),
	COLORS.CYAN: preload("res://Assets/Materials/Slot/Dimm/cyan_dimm.material"),
	COLORS.BLUE: preload("res://Assets/Materials/Slot/Dimm/blue_dimm.material"),
	COLORS.PURPLE: preload("res://Assets/Materials/Slot/Dimm/purple_dimm.material"),
	COLORS.PINK: preload("res://Assets/Materials/Slot/Dimm/pink_dimm.material")
}

const LIT_MATERIAL_MAP: Dictionary[COLORS, StandardMaterial3D] = {
	COLORS.WHITE: preload("res://Assets/Materials/Slot/Lit/white_lit.material"),
	COLORS.RED: preload("res://Assets/Materials/Slot/Lit/red_lit.material"),
	COLORS.ORANGE: preload("res://Assets/Materials/Slot/Lit/orange_lit.material"),
	COLORS.YELLOW: preload("res://Assets/Materials/Slot/Lit/yellow_lit.material"),
	COLORS.GREEN: preload("res://Assets/Materials/Slot/Lit/green_lit.material"),
	COLORS.CYAN: preload("res://Assets/Materials/Slot/Lit/cyan_lit.material"),
	COLORS.BLUE: preload("res://Assets/Materials/Slot/Lit/blue_lit.material"),
	COLORS.PURPLE: preload("res://Assets/Materials/Slot/Lit/purple_lit.material"),
	COLORS.PINK: preload("res://Assets/Materials/Slot/Lit/pink_lit.material")
}

var state: bool = false
var color: COLORS = COLORS.WHITE

@onready var light: MeshInstance3D = get_node(^"%Light")


func _ready() -> void:
	light.mesh = light.mesh.duplicate()




#region SIGNAL / FUNCTION
# without prefix
func get_function_names() -> Array[String]:
	return ["State", "Color"]

func get_function_descriptions() -> Array[String]:
	return [
		"Set the state of the Slot's light.",
		"""Set the color of the Slot's light.
		Possible values are : { 0: White, 1: RED, 2: ORANGE, 3: YELLOW, 4: GREEN, 5: CYAN, 6: BLUE, 7: PURPLE, 8: PINK }.
		Anything else will default to White."""
	]

func get_function_arguments() -> Array[Dictionary]:
	return [
		{"enabled": DATA_TYPES.BOOL},
		{"color": DATA_TYPES.INT}
	]

# prefixed with sig_
func get_function(_name: String) -> Callable:
	match _name:
		"State": return func_state
		"Color": return func_color
		_: return Callable()
#endregion


#region SIGNAL / SIGNAL
# without prefix
func get_signal_names() -> Array[String]:
	return ["State", "Color"]

func get_signal_descriptions() -> Array[String]:
	return [
		"Get the state of the Slot's light.",
		"""Set the color of the Slot's light.
		Possible values are : { 0: White, 1: RED, 2: ORANGE, 3: YELLOW, 4: GREEN, 5: CYAN, 6: BLUE, 7: PURPLE, 8: PINK }."""
	]

func get_signal_arguments() -> Array[Dictionary]:
	return [
		{"enabled": DATA_TYPES.BOOL},
		{"color": DATA_TYPES.INT}
	]

# prefixed with sig_
func get_signal(_name: String) -> Signal:
	match _name:
		"State": return sig_state
		"Color": return sig_color
		_: return Signal()

#endregion




#region Signal Layer
## Get the state of the light (on/off)
signal sig_state(enabled: bool)
## Get the color of the light (COLORS enum)
signal sig_color(_color: int)

## Set the state of the light (on/off)
func func_state(enabled: bool) -> void:
	state = enabled
	sig_state.emit(state)
	_update_light()

## Set the color of the light (COLORS enum, otherwise white)
func func_color(_color: int) -> void:
	if _color not in range(COLORS.WHITE, COLORS.MAX):
		color = COLORS.WHITE
	else:
		color = _color as COLORS
	sig_color.emit(color)
	_update_light()

#endregion




func _update_light() -> void:
	if state:
		light.mesh.set(&"surface_0/material", LIT_MATERIAL_MAP.get(color))
	else:
		light.mesh.set(&"surface_0/material", DIMM_MATERIAL_MAP.get(color))
