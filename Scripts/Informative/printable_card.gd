extends PrintableCard

@onready var outer_layer : Panel = $OuterLayer;
@onready var inner_layer : Panel = $InnerLayer;
@onready var name_label : Label = $NameLabel;
@onready var power_label : Label = $PowerLabel;
@onready var art_sprite : Sprite2D = $ArtSprite;

func update_visuals() -> void:
	power_label.text = ("%s 000" if card_data.power > 0 else "%s") % str(card_data.power / 1000);
	set_inner_panel();
	update_name();
	update_art();

func update_name() -> void:
	var font_size : int = 104;
	if card_data.card_name.length() > 12:
		font_size -= (card_data.card_name.length() - 10) * 3.5;
	name_label.text = card_data.card_name;
	name_label.add_theme_font_size_override("font_size", font_size);

func set_inner_panel() -> void:
	var style : StyleBoxFlat = StyleBoxFlat.new();
	var bg_color : String;
	match card_data.card_type:
		CardEnums.CardType.ROCK:
			bg_color = INNER_PANEL_COLOR_ROCK;
		CardEnums.CardType.PAPER:
			bg_color = INNER_PANEL_COLOR_PAPER;
		CardEnums.CardType.SCISSORS:
			bg_color = INNER_PANEL_COLOR_SCISSORS;
	style.corner_radius_bottom_left = INNER_PANEL_CORNER_RADIUS;
	style.corner_radius_bottom_right = INNER_PANEL_CORNER_RADIUS;
	style.corner_radius_top_left = INNER_PANEL_CORNER_RADIUS;
	style.corner_radius_top_right = INNER_PANEL_CORNER_RADIUS;
	style.bg_color = bg_color;
	inner_layer.add_theme_stylebox_override("panel", style);

func update_art():
	var texture : Resource = load(CARD_ART_PATH % [card_data.card_id, card_data.card_name]);
	art_sprite.texture = texture;
