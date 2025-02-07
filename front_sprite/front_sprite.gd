extends TextureRect

const SCALE_SMALL: Vector2 = Vector2(0.01, 0.01)
const SCALE_NORMAL: Vector2 = Vector2(1.0, 1.0)
const SPIN_TIME_RANGE: Vector2 = Vector2(1.0, 2.0)
const SCALE_TIME: float = 0.8

# Called when the node enters the scene tree for the first time.
func _ready():
	run_me()

func set_random_image() -> void:
	texture = ImageManager.get_random_item_image().item_texture

func get_random_spin_time() -> float:
	return randf_range(SPIN_TIME_RANGE.x, SPIN_TIME_RANGE.y)

func get_random_rotation() -> float:
	return deg_to_rad(randf_range(0, 360))

func run_me() -> void:
	var tween = get_tree().create_tween()
	tween.tween_callback(set_random_image)
	tween.tween_property(self, "scale", SCALE_NORMAL, SCALE_TIME).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_interval(4)
	tween.tween_property(self, "scale", SCALE_SMALL, SCALE_TIME).set_trans(Tween.TRANS_ELASTIC)
	
	tween.tween_callback(run_me)
