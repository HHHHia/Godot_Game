extends Area2D

@export var slime_speed : float = -100

var is_die : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_die:
		position += Vector2(slime_speed,0) * delta
	if position.x <= -260:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not is_die:
		body.game_over()
	


func get_hit(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		area.queue_free()
		get_tree().current_scene.score += 1
		$AnimatedSprite2D.play("die")
		$dead.play()
		is_die = true
		await get_tree().create_timer(0.6).timeout
		queue_free()
		
