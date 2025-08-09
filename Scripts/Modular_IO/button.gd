extends SignalComponent

@onready var _interactable: Interactable = get_node(^"%Interactable")

#region SIGNAL / FUNCTION
# without prefix
func get_function_names() -> Array[String]:
	return ["Trigger"]

func get_function_descriptions() -> Array[String]:
	return ["Push the button."]

func get_function_arguments() -> Array[Dictionary]:
	return []

# prefixed with sig_
func get_function(_name: String) -> Callable:
	match _name:
		"Trigger": return func_trigger
		_: return Callable()
#endregion


#region SIGNAL / SIGNAL
# without prefix
func get_signal_names() -> Array[String]:
	return ["Trigger"]

func get_signal_descriptions() -> Array[String]:
	return ["Was the button pressed?"]

func get_signal_arguments() -> Array[Dictionary]:
	return [{"pressed": DATA_TYPES.BOOL}]

# prefixed with sig_
func get_signal(_name: String) -> Signal:
	match _name:
		"Trigger": return sig_trigger
		_: return Signal()

#endregion




#region Signal Layer
## If the button was pressed (on/off)
signal sig_trigger(pressed: bool)

## Trigger the button
func func_trigger() -> void:
	sig_trigger.emit()
	_interactable._trigger()
#endregion

func _trigger(pressed: bool) -> void:
	sig_trigger.emit(pressed)
