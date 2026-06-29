extends Gameplay

@onready var card : PrintableCard = $CardLayer;

func _ready() -> void:
	current_card_id = Config.STARTING_CARD_ID;
	load_card();

func _process(delta : float) -> void:
	if Input.is_action_just_pressed("take_screenshot"):
		take_screenshot();
	if Input.is_action_just_pressed("next_card"):
		load_next_card();
	if Input.is_action_just_pressed("previous_card"):
		load_previous_card();

func take_screenshot() -> void:
	System.Json.take_screenshot(card, "%s - %s" % [str(card.card_data.card_id), card.get_name_path() + (" (%s)" % (alt_art_id + 1) if alt_art_id > 0 else "")], \
		PrintableCard.OUTER_LAYER_PRINT_SCALE if Config.PRINT_MODE \
		else PrintableCard.OUTER_LAYER_BASE_SCALE, \
		0 if Config.PRINT_MODE else 75);
	if Config.SCREENSHOT_ALL:
		await System.wait(0.1);
		load_next_card();
		await System.wait(0.1);
		take_screenshot();

func load_next_card() -> void:
	if alt_art_id < card.card_data.alt_arts:
		alt_art_id += 1;
	else:
		current_card_id += 1;
		alt_art_id = 0;
	if current_card_id > Config.MAX_CARD_ID:
		current_card_id = 1;
	load_card();

func load_card() -> void:
	card.load_card_data(current_card_id, alt_art_id);

func load_previous_card() -> void:
	var did_back_from_alt_art : bool;
	if alt_art_id > 0:
		alt_art_id -= 1;
		did_back_from_alt_art = true;
	else:
		current_card_id -= 1;
		alt_art_id = 0;
	if current_card_id == 0:
		current_card_id = Config.MAX_CARD_ID;
	load_card();
	if !did_back_from_alt_art:
		alt_art_id = card.card_data.alt_arts;
		load_card();
