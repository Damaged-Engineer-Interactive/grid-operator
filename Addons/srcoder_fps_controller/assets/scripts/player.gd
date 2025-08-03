extends CharacterBody3D

@export var light_active: bool = false

## The movement speed in m/s. Default is 5.
@export var speed : float = 5.0
## The Jump Velocity in m/s- default to 6.0
@export var jump_velocity : float = 6.0

## Mouse sensitivity for looking around. Default is 3.0
@export var mouse_sensitivity = 3.0
var mouse_motion : Vector2 = Vector2.ZERO
var pitch = 0

## The amount of acceleration on the ground- less feels floaty, more is snappy-[br]Default is 4
@export var ground_acceleration := 4.0
## the amount of acceleration when in the air. less feels more floaty more is more snappy.[br]Default is 0.5
@export var air_acceleration := 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity : float = 9.8

# the camera pivot for head pitch movement
@onready var camera_pivot : Node3D = $CameraPivot

func _ready() -> void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(&"light"):
		light_active = not light_active
		%Light.light_energy = int(light_active)

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y))
	var target_velocity := Vector3.ZERO
	if direction:
		target_velocity = direction
	#now apply velocity with lerp based on whether on ground or in air
	if is_on_floor():
		velocity.x = move_toward(velocity.x , target_velocity.x * speed , speed * ground_acceleration * delta)
		velocity.z = move_toward(velocity.z, target_velocity.z * speed, speed * ground_acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x , target_velocity.x * speed , speed * air_acceleration * delta)
		velocity.z = move_toward(velocity.z, target_velocity.z * speed, speed * air_acceleration * delta)
	#now actually move based on velocity
	move_and_slide()
	
	#rotate the player and camera pivot based on mouse movement
	rotate_y(-mouse_motion.x * mouse_sensitivity / 1000)
	pitch -= mouse_motion.y * mouse_sensitivity / 1000
	pitch = clampf(pitch,-1.35,1.35)
	camera_pivot.rotation.x = pitch
	#reset it
	mouse_motion = Vector2.ZERO
	

#handle and store mouse motion
func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		mouse_motion = event.relative
		
