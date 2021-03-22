extends KinematicBody
 
# physics
var moveSpeed : float = 5.0
var jumpForce : float = 5.0
var gravity : float = 12.0
 
# cam look
var minLookAngle : float = -90.0
var maxLookAngle : float = 90.0
var lookSensitivity : float = 10.0
 
# vectors
var vel : Vector3 = Vector3()
var mouseDelta : Vector2 = Vector2()
 
# components
onready var camera : Camera = get_node("Camera")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(delta):
 
	# reset the x and z velocity
	vel.x = 0
	vel.z = 0
	
	var input = Vector2()
	
	# movement inputs
	if Input.is_action_pressed("move_forward"):
		input.y -= 1
	if Input.is_action_pressed("move_backward"):
		input.y += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_right"):
		input.x += 1
		
	input = input.normalized()
	
	# get the forward and right directions
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	
	var relativeDir = (forward * input.y + right * input.x)
	
	# set the velocity
	vel.x = relativeDir.x * moveSpeed
	vel.z = relativeDir.z * moveSpeed
	
	# apply gravity
	vel.y -= gravity * delta
	
	# move the player
	vel = move_and_slide(vel, Vector3.UP)
	
	# jumping
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y = jumpForce
		
		
func _process(delta):
	
	# rotate the camera along the x axis
	camera.rotation_degrees.x -= mouseDelta.y * lookSensitivity * delta
	
	# clamp camera x rotation axis
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minLookAngle, maxLookAngle)
	
	# rotate the player along their y-axis
	rotation_degrees.y -= mouseDelta.x * lookSensitivity * delta
	
	# reset the mouseDelta vector
	mouseDelta = Vector2()
 
func _input(event):
	
	if event is InputEventMouseMotion:
		mouseDelta = event.relative
	if Input.is_action_pressed("flashlight"):
		var spotlight: SpotLight = self.get_node("SpotLight")
		spotlight.light_energy = 1 if spotlight.light_energy == 0 else 0
