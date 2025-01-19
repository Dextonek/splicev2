extends CharacterBody3D

@export var speed: float = 5.0
@export var follow_mouse: bool = false
@export var plane_height: float = 0.0  # The Y-coordinate of the imaginary plane

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
	var from = camera.project_ray_origin(mouse_pos)
	var direction = camera.project_ray_normal(mouse_pos)
	
	# Define an imaginary plane at Y = plane_height
	var plane = Plane(Vector3.UP, plane_height)
	
	# Intersect the ray with the plane
	var intersection = plane.intersects_ray(from, direction)
	
	if intersection:
		target_position = intersection
		# Optionally, keep the Y position the same as the player's current Y
		# target_position.y = global_position.y

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
