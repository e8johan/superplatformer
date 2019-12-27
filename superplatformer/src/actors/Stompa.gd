extends ActorBase
class_name Stompa, "res://assets/monsters/stompa/stompa_symbol.png"

export var stop_at_edges : bool = true setget _set_stop_at_edges

onready var groundDetectorRight = $GroundDetectorRight
onready var groundDetectorLeft = $GroundDetectorLeft

func _ready() -> void:
    _velocity.x = speed.x
    _set_stop_at_edges(stop_at_edges)

func _physics_process(delta: float) -> void:
    _velocity.y += gravity * delta
    if is_on_wall() or (stop_at_edges and (not groundDetectorRight.is_colliding() or not groundDetectorLeft.is_colliding())):
        _velocity.x = -_velocity.x
    _velocity.y = move_and_slide(_velocity, Vector2.UP).y
    
func _set_stop_at_edges(val : bool) -> void:
    stop_at_edges = val
    
    if groundDetectorLeft:
        groundDetectorLeft.enabled = val
    if groundDetectorRight:
        groundDetectorRight.enabled = val