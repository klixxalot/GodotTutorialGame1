extends Node2D

const SPEED = 60
var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
#@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $Slime/AnimatedSprite2D
@onready var game_manager: Node = %GameManager
@onready var killzone: Area2D = $Killzone


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
		#print("Colided Right")
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
		#print("Colided Left")
	position.x += direction * SPEED * delta


func _on_slime_area_entered(area: Area2D) -> void:
	#print(JSON.stringify(area))
	if area.is_in_group("Sword"):
		killzone.monitoring = false
		animated_sprite_2d.play("death")
		await animated_sprite_2d.animation_finished
		game_manager.add_points(10)
		queue_free()
