extends CharacterBody3D

@export var speed: float = 5.0
@export var follow_mouse: bool = false

var target_position: Vector3 = Vector3.ZERO

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		follow_mouse = event.pressed
		if follow_mouse:
			update_target_position()

func _process(delta):
	if follow_mouse:
		update_target_position()

func update_target_position():
	var camera = get_viewport().get_camera_3d()
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 1000
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = space_state.intersect_ray(query)
	
	if result:
		target_position = result.position
		# Keep the Y position the same as the player's current Y
		target_position.y = global_position.y

func _physics_process(delta):
	if target_position != Vector3.ZERO:
		var direction = (target_position - global_position).normalized()
		direction.y = 0  # Ensure movement only on X and Z axes
		
		if global_position.distance_to(target_position) > 0.1:
			velocity = direction * speed
		else:
			velocity = Vector3.ZERO
			if not follow_mouse:
				target_position = Vector3.ZERO
		
		move_and_slide()
