extends SignalComponent

var state: bool = false

@onready var _interactable: Interactable = get_node(^"%Interactable")


#region SIGNAL / FUNCTION
# without prefix
func get_function_names() -> Array[String]:
	return ["State"]

func get_function_descriptions() -> Array[String]:
	return ["Set the state of the switch."]

func get_function_arguments() -> Array[Dictionary]:
	return [{"enabled": DATA_TYPES.BOOL}]

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
	return [{"enabled": DATA_TYPES.BOOL}]

# prefixed with sig_
func get_signal(_name: String) -> Signal:
	match _name:
		"State": return sig_state
		_: return Signal()

#endregion




#region Signal Layer
## Get the state of the switch (on/off)
signal sig_state(enabled: bool)

## Set the state of the switch (on/off)
func func_state(enabled: bool) -> void:
	state = enabled
	sig_state.emit(state)
	_interactable._set_switch(enabled)

#endregion

func _set_state(enabled: bool) -> void:
	state = enabled
	sig_state.emit(state)
