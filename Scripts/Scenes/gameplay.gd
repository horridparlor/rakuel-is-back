extends Gameplay

@onready var card : Node2D = $CardLayer;

func _ready() -> void:
	pass;


func _process(delta : float) -> void:
	if Input.is_action_just_pressed("take_screenshot"):
		System.Json.take_screenshot(card, "", Vector2(1126, 1552), 90);
