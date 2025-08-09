extends SignalComponent

var state: int = 0

@onready var _interactable: Interactable = get_node(^"%Interactable")


#region SIGNAL / FUNCTION
# without prefix
func get_function_names() -> Array[String]:
	return ["State"]

func get_function_descriptions() -> Array[String]:
	return ["Set the state of the switch."]

func get_function_arguments() -> Array[Dictionary]:
	return [{"position": DATA_TYPES.INT}]

# prefixed with sig_
func get_function(_name: String) -> Callable:
	match _name:
		"State": return func_state
		_: return Callable()
#endregion


#region SIGNAL / SIGNAL
# without prefix
func get_signal_names() -> Array[String]:
	return ["State"]

func get_signal_descriptions() -> Array[String]:
	return ["Get the state of the switch."]

func get_signal_arguments() -> Array[Dictionary]:
	return [{"position": DATA_TYPES.INT}]

# prefixed with sig_
func get_signal(_name: String) -> Signal:
	match _name:
		"State": return sig_state
		_: return Signal()

#endregion




#region Signal Layer
## Get the state of the switch (0/1/2)
signal sig_state(position: int)

## Set the state of the switch (0/1/2)
func func_state(position: int) -> void:
	state = position
	sig_state.emit(state)
	_interactable._set_switch(position)

#endregion

func _set_state(position: int) -> void:
	state = position
	sig_state.emit(state)
