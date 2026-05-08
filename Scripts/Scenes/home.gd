extends Home

func _ready() -> void:
	System.init();
	gameplay = System.Instance.load_child(System.Paths.Scenes.GAMEPLAY, self);

func _process(delta : float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit();
