extends CharacterBody3D

# Movement speed
var speed: float = 5.0
var target_position: Vector3 = Vector3.ZERO
var is_moving: bool = false

func _ready():
	# Lock the mouse pointer to the screen
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Get the clicked position using RayCast
		var camera = get_viewport().get_camera_3d()
		if camera:
			var ray_origin = camera.project_ray_origin(event.position)
			var ray_direction = camera.project_ray_normal(event.position)
			var space_state = get_world_3d().direct_space_state
			var result = space_state.intersect_ray(ray_origin, ray_origin + ray_direction * 1000)
			if result:
				target_position = result.position
				is_moving = true

func _physics_process(delta):
	if is_moving:
		# Calculate direction to the target position
		var direction = (target_position - global_transform.origin).normalized()

		# Move the player towards the target position
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed

		# Stop when close to the target
		if global_transform.origin.distance_to(target_position) < 0.1:
			is_moving = false
			velocity = Vector3.ZERO

		# Apply the movement
		velocity = move_and_slide(velocity, Vector3.UP)
