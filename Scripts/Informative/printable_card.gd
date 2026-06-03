extends PrintableCard

@onready var outer_layer : Panel = $OuterLayer;
@onready var inner_layer : Panel = $InnerLayer;
@onready var name_label : Label = $NameLabel;
@onready var power_label : Label = $PowerLabel;
@onready var art_sprite : Sprite2D = $ArtSprite;
@onready var power_panel : Panel = $PowerPanel;
@onready var id_label : Label = $Footer/IdLabel;
@onready var type_icon : Sprite2D = $Footer/TypeIcon;
@onready var type_label : Label = $Footer/TypeLabel;
@onready var credit_label : Label = $Footer/CreditLabel;
@onready var effects_label : RichTextLabel = $EffectsLabel;

func update_visuals() -> void:
	update_power();
	set_inner_panel();
	update_name();
	update_art();
	update_footer();
	update_effects();

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
	style.bg_color = bg_color;
	System.Styles.set_all_corners(style, INNER_PANEL_CORNER_RADIUS);
	inner_layer.add_theme_stylebox_override("panel", style);

func update_art() -> void:
	var texture : Resource = load(CARD_ART_PATH % [card_data.card_id, card_data.card_name]);
	art_sprite.texture = texture;

func update_power() -> void:
	power_label.text = ("%s 000" if card_data.power > 0 else "%s") % str(card_data.power / 1000);
	set_power_panel();

func set_power_panel() -> void:
	var style : StyleBoxFlat = StyleBoxFlat.new();
	var bg_color : String;
	var corner_radius : int = POWER_PANEL_CORNER_RADIUS;
	var width : int = POWER_PANEL_THOUSAND_WIDTH;
	if card_data.power == 0:
		width = POWER_PANEL_ZERO_WIDTH;
	elif card_data.power >= 10000:
		width = POWER_PANEL_TEN_THOUSAND_WIDTH
	power_panel.size.x = width;
	power_panel.position.x = -width / 2;
	match card_data.card_type:
		CardEnums.CardType.ROCK:
			bg_color = POWER_PANEL_COLOR_ROCK;
			style.corner_detail = 1;
			corner_radius = POWER_PANEL_ROCK_CORNER_RADIUS;
		CardEnums.CardType.PAPER:
			bg_color = POWER_PANEL_COLOR_PAPER;
		CardEnums.CardType.SCISSORS:
			bg_color = POWER_PANEL_COLOR_SCISSORS;
			corner_radius = 0;
	style.bg_color = bg_color;
	System.Styles.set_all_corners(style, corner_radius);
	System.Styles.set_all_borders(style, POWER_PANEL_BORDER_WIDTH);
	style.border_color = Color.WHITE;
	power_panel.add_theme_stylebox_override("panel", style);

func update_footer() -> void:
	var type_icon_x : int;
	var type_icon_texture : Texture = load(TYPE_ICON_PATH % CardEnums.TranslateCardType[card_data.card_type].to_lower());
	match card_data.card_type:
		CardEnums.CardType.ROCK:
			type_icon_x = TYPE_ICON_ROCK_X;
		CardEnums.CardType.PAPER:
			type_icon_x = TYPE_ICON_PAPER_X;
		CardEnums.CardType.SCISSORS:
			type_icon_x = TYPE_ICON_SCISSORS_X;
	type_icon.position.x = type_icon_x;
	type_icon.texture = type_icon_texture;
	id_label.text = ID_LABEL_TEXT % str(card_data.card_id).pad_zeros(ID_LABEL_LENGTH);
	type_label.text = CardEnums.TranslateCardType[card_data.card_type];
	credit_label.text = CREDIT_LABEL_TEXT % card_data.release_year;
	

func update_effects() -> void:
	effects_label.text = card_data.get_effects_text();
