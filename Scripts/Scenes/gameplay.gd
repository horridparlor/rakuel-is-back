extends Gameplay

@onready var card : PrintableCard = $CardLayer;

func _ready() -> void:
	load_next_card();


func _process(delta : float) -> void:
	if Input.is_action_just_pressed("take_screenshot"):
		System.Json.take_screenshot(card, "", Vector2(1126, 1552), 90);
	if Input.is_action_just_pressed("next_card"):
		load_next_card();
	if Input.is_action_just_pressed("previous_card"):
		load_previous_card();

func load_next_card() -> void:
	current_card_id += 1;
	if current_card_id > Config.MAX_CARD_ID:
		current_card_id = 1;
	card.load_card_data(current_card_id);

func load_previous_card() -> void:
	current_card_id -= 1;
	if current_card_id == 0:
		current_card_id = Config.MAX_CARD_ID;
	card.load_card_data(current_card_id);
