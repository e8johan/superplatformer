extends ActorBase
class_name Player, "res://assets/player/player_symbol.png"

func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
    queue_free()

func _physics_process(delta: float) -> void:
    var cancel_jump := Input.is_action_just_released("move_jump") and _velocity.y < 0.0
    var direction := get_direction()
    _velocity = calculate_move_velocity(_velocity, direction, speed, cancel_jump)
    _velocity = move_and_slide(_velocity, Vector2.UP)
    
func get_direction() -> Vector2:
    return Vector2(
        Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
        -1.0 if Input.is_action_just_pressed("move_jump") and is_on_floor() else 1.0
    )
    
func calculate_move_velocity(
        linear_velocity: Vector2,
        direction: Vector2,
        speed: Vector2,
        cancel_jump: bool
    ) -> Vector2:
    var res = linear_velocity
    res.x = speed.x * direction.x
    res.y += gravity * get_physics_process_delta_time()
    if direction.y == -1.0:
        res.y = speed.y * direction.y
    if cancel_jump:
        res.y = 0.0
    return res
