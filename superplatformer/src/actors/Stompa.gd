extends ActorBase
class_name Stompa, "res://assets/monsters/stompa/stompa_symbol.png"

func _ready() -> void:
    _velocity.x = speed.x

func _physics_process(delta: float) -> void:
    _velocity.y += gravity * delta
    if is_on_wall():
        _velocity.x = -_velocity.x
    _velocity.y = move_and_slide(_velocity, Vector2.UP).y