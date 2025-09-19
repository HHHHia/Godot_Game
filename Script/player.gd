extends CharacterBody2D

@export var move_speed : float = 35
@export var animator : AnimatedSprite2D
var is_game_over : bool = false
@export var bullet_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if velocity == Vector2.ZERO or is_game_over:
		$running.stop()
	elif not $running.playing:
		$running.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_game_over:
		velocity = Input.get_vector("Left","Right","Up","Down") * move_speed
		if velocity == Vector2.ZERO:
			animator.play("idle")
		else:
			animator.play("run")
		move_and_slide()

func game_over():
	if not is_game_over:
		is_game_over = true
		animator.play("game_over")
		get_tree().current_scene.show_game_over()
		$Game_over.play()
		$RestarTimer.start()



func _on_fire() -> void:
	if velocity != Vector2.ZERO or is_game_over:
		return
	$gun_fire.play()
	var bullet_node = bullet_scene.instantiate()
	bullet_node.position = position + Vector2(17,7)
	get_tree().current_scene.add_child(bullet_node)


func reload_scene() -> void:
	get_tree().reload_current_scene()
