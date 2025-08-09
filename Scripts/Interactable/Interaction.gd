extends RayCast3D

var current_collider

@onready var primary_container: PanelContainer = get_node(^"/root/World/%PrimaryAction")
@onready var primary_label: Label = get_node(^"/root/World/%PrimaryActionLabel")

@onready var secondary_container: PanelContainer = get_node(^"/root/World/%SecondaryAction")
@onready var secondary_label: Label = get_node(^"/root/World/%SecondaryActionLabel")

@onready var increase_container: PanelContainer = get_node(^"/root/World/%IncreaseAction")
@onready var increase_label: Label = get_node(^"/root/World/%IncreaseActionLabel")

@onready var decrease_container: PanelContainer = get_node(^"/root/World/%DecreaseAction")
@onready var decrease_label: Label = get_node(^"/root/World/%DecreaseActionLabel")

func _ready() -> void:
	set_interaction_text()

func _process(_delta: float) -> void:
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			current_collider = collider
			set_interaction_text(collider)
		
		if Input.is_action_just_pressed(&"primary") and collider.primary_text() != "":
			collider.primary()
			set_interaction_text(collider)
		
		if Input.is_action_just_pressed(&"secondary") and collider.secondary_text() != "":
			collider.secondary()
			set_interaction_text(collider)
		
		if Input.is_action_just_pressed(&"increase") and collider.increase_text() != "":
			collider.increase()
			set_interaction_text(collider)
		
		if Input.is_action_just_pressed(&"decrease") and collider.decrease_text() != "":
			collider.decrease()
			set_interaction_text(collider)
		
	elif current_collider:
		current_collider = null
		set_interaction_text()

func set_interaction_text(collider: Interactable = null):
	if collider:
		if collider.primary_text() != "":
			primary_container.show()
			primary_label.text = collider.primary_text()
		else:
			primary_container.hide()
		
		if collider.secondary_text() != "":
			secondary_container.show()
			secondary_label.text = collider.secondary_text()
		else:
			secondary_container.hide()
		
		if collider.increase_text() != "":
			increase_container.show()
			increase_label.text = collider.increase_text()
		else:
			increase_container.hide()
		
		if collider.decrease_text() != "":
			decrease_container.show()
			decrease_label.text = collider.decrease_text()
		else:
			decrease_container.hide()
	else:
		primary_container.hide()
		secondary_container.hide()
	
