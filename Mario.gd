extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector3(0.0, 0.0, 0.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_left"):
		rotate(Vector3.UP, 0.02)
	elif Input.is_action_pressed("ui_right"):
		rotate(Vector3.UP, -0.02)
	
	var friction: float = get_floor_normal().dot(Vector3.UP)
	#print_debug("friction %s %s" % [str(friction), str(get_floor_velocity())])
	
	if (friction > 0.95):
		velocity.x = 0
		velocity.z = 0
		
		if Input.is_action_pressed("ui_up"):
			velocity.x = -1 * transform.basis.z.x
			velocity.z = -1 * transform.basis.z.z
		elif Input.is_action_pressed("ui_down"):
			velocity.x = 1 * transform.basis.z.x
			velocity.z = 1 * transform.basis.z.z
		
	else:
		velocity.x *= 0.95
		velocity.z *= 0.95
		
		if Input.is_action_pressed("ui_up"):
			velocity.x += -0.025 * transform.basis.z.x
			velocity.z += -0.025 * transform.basis.z.z
		elif Input.is_action_pressed("ui_down"):
			velocity.x += 0.025 * transform.basis.z.x
			velocity.z += 0.025 * transform.basis.z.z
	
	#if not is_on_floor():
	velocity.y -= 0.05
	
	velocity = move_and_slide(velocity, Vector3.UP, true)


func start_playing():
	$Camera.make_current()
