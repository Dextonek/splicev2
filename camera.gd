extends Camera3D

@export var target_path: NodePath
@export var smoothing: float = 5.0
@export var offset: Vector3 = Vector3(0, 5, 10)

var target: Node3D

func _ready():
	if target_path:
		target = get_node(target_path)

func _process(delta):
	if target:
		var target_pos = target.global_transform.origin + offset
		global_transform.origin = global_transform.origin.lerp(target_pos, smoothing * delta)
		look_at(target.global_transform.origin, Vector3.UP)
