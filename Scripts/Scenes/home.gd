extends Home

@onready var camera : Camera2D = $Camera2D;

func _ready() -> void:
	System.init();
	gameplay = System.Instance.load_child(System.Paths.Scenes.GAMEPLAY, self);
	camera.zoom = Vector2(2.0 / 3.0, 2.0 / 3.0);

func _process(delta : float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit();
