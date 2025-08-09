extends SignalComponent

@onready var _interactable: Interactable = get_node(^"%Interactable")


#region SIGNAL / FUNCTION
# without prefix
func get_function_names() -> Array[String]:
	return ["Value"]

func get_function_descriptions() -> Array[String]:
	return ["Set the value of the potentiometer."]

func get_function_arguments() -> Array[Dictionary]:
	return [{"value": DATA_TYPES.INT}]

# prefixed with sig_
func get_function(_name: String) -> Callable:
	match _name:
		"Value": return func_value
		_: return Callable()
#endregion


#region SIGNAL / SIGNAL
# without prefix
func get_signal_names() -> Array[String]:
	return ["Value"]

func get_signal_descriptions() -> Array[String]:
	return ["Get the value of the potentiometer."]

func get_signal_arguments() -> Array[Dictionary]:
	return [{"value": DATA_TYPES.INT}]

# prefixed with sig_
func get_signal(_name: String) -> Signal:
	match _name:
		"Vaue": return sig_value
		_: return Signal()

#endregion




#region Signal Layer
## Get the value of the potentiometer (0..100)
signal sig_value(value: int)

## Set the value of the potentiometer (0..100)
func func_value(value: int) -> void:
	sig_value.emit(value)
	_interactable._set_value(value)

#endregion

func _set_value(value: int) -> void:
	sig_value.emit(value)
