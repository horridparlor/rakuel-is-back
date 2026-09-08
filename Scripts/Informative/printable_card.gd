extends PrintableCard

@onready var outer_layer : Panel = $OuterLayer;
@onready var inner_layer : Panel = $InnerLayer;
@onready var inner_pattern : Sprite2D = $InnerPattern;
@onready var name_label : RichTextLabel = $NameLabel;
@onready var power_label : Label = $PowerLabel;
@onready var art_sprite : Sprite2D = $ArtSprite;
@onready var power_panel : Panel = $PowerPanel;
@onready var power_panel_gun_back : Polygon2D = $PowerPanelGunBack;
@onready var power_panel_gun_front : Polygon2D = $PowerPanelGunFront;
@onready var power_pattern : Sprite2D = $PowerPattern;
@onready var id_label : Label = $Footer/IdLabel;
@onready var type_icon : Sprite2D = $Footer/TypeIcon;
@onready var type_label : Label = $Footer/TypeLabel;
@onready var credit_label : Label = $Footer/CreditLabel;
@onready var effects_label : RichTextLabel = $EffectsLabel;
@onready var gravestone_icon : Sprite2D = $GravestoneIcon;

func _ready() -> void:
	update_outer_layer();

func update_visuals() -> void:
	update_power();
	update_inner_panel();
	update_name();
	update_art();
	update_footer();
	update_effects();

func update_name() -> void:
	var font_size : int = 104;
	var display_name : String = card_data.card_name;
	var has_the : bool;
	var tagless_name : String = System.Strings.remove_bbcode_tags(card_data.card_name);
	name_label.position.y = -599;
	if tagless_name.length() > 24:
		font_size -= (tagless_name.length() - 10) * 2.9;
		name_label.position.y += tagless_name.length() - 10;
	elif tagless_name.length() > 12:
		font_size -= (tagless_name.length() - 10) * 3.5;
		name_label.position.y += tagless_name.length() - 10;
	if display_name.begins_with("The "):
		display_name = "[font_size=%s][i]The [/i][/font_size]" % (font_size - 4) + display_name.substr(4);
		has_the = true;
	elif display_name.begins_with("The_"):
		display_name = "[font_size=%s][i]The_[/i][/font_size]" % (font_size - 4) + display_name.substr(4);
		has_the = true;
	else:
		var regex : RegEx = RegEx.new();
		regex.compile("^((?:[^-\\s']+-)+[^-\\s']+|[^\\s']+'s)(?:\\s+(.+))?$");

		var result : RegExMatch = regex.search(display_name);
		if result:
			display_name = "[font_size=%s][i]%s[/i][/font_size]%s" % [
				font_size - 4,
				result.get_string(1),
				"" if result.get_string(2).is_empty() else " " + result.get_string(2)
			];
	name_label.text = "[font_size=%s]%s[/font_size]" % [font_size, display_name];

func update_inner_panel() -> void:
	var style : StyleBoxFlat = StyleBoxFlat.new();
	var bg_color : String;
	var inner_pattern_texture : Texture = load(INNER_PATTERN_PATH % card_data.card_type_name);
	inner_pattern.texture = inner_pattern_texture;
	match card_data.card_type:
		CardEnums.CardType.ROCK:
			bg_color = INNER_PANEL_COLOR_ROCK;
		CardEnums.CardType.PAPER:
			bg_color = INNER_PANEL_COLOR_PAPER;
		CardEnums.CardType.SCISSORS:
			bg_color = INNER_PANEL_COLOR_SCISSORS;
		CardEnums.CardType.GUN:
			bg_color = INNER_PANEL_COLOR_GUN;
	style.bg_color = bg_color;
	System.Styles.set_all_corners(style, INNER_PANEL_CORNER_RADIUS);
	inner_layer.add_theme_stylebox_override("panel", style);

func update_art() -> void:
	var texture : Resource = load(CARD_ART_PATH % [card_data.card_id, get_name_path() + (" (%s)" % (alt_art_id + 1) if alt_art_id > 0 else "")]);
	art_sprite.texture = texture;

func update_power() -> void:
	power_label.text = ("%s 000" if card_data.power > -1 else "%s") % str(card_data.power / 1000);
	set_power_panel();

func set_power_panel() -> void:
	var style : StyleBoxFlat = StyleBoxFlat.new();
	var bg_color : String;
	var corner_radius : int = POWER_PANEL_CORNER_RADIUS;
	var width : int = POWER_PANEL_THOUSAND_WIDTH;
	var power_pattern_texture : Texture;
	var power_pattern_size_name : String = "normal";
	if card_data.power == 0:
		#width = POWER_PANEL_ZERO_WIDTH;
		#power_pattern_size_name = "short";
		pass;
	elif card_data.power >= 10000:
		width = POWER_PANEL_TEN_THOUSAND_WIDTH;
		power_pattern_size_name = "long";
	power_pattern_texture = load(POWER_PATTERN_PATH % [card_data.card_type_name, power_pattern_size_name]);
	power_pattern.texture = power_pattern_texture;
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
		CardEnums.CardType.GUN:
			bg_color = POWER_PANEL_COLOR_GUN;
	style.bg_color = bg_color;
	System.Styles.set_all_corners(style, corner_radius);
	System.Styles.set_all_borders(style, POWER_PANEL_BORDER_WIDTH);
	style.border_color = Color.WHITE;
	power_panel.add_theme_stylebox_override("panel", style);
	var is_gun : bool = card_data.card_type == CardEnums.CardType.GUN;
	power_panel.visible = not is_gun;
	power_panel_gun_back.visible = is_gun;
	power_panel_gun_front.visible = is_gun;
	if is_gun:
		var outer_rect : Rect2 = Rect2(power_panel.position, power_panel.size);
		var segment_counts : Array = System.Styles.compute_serrated_segment_counts(outer_rect.size, POWER_PANEL_GUN_TOOTH_LENGTH / 2.0, POWER_PANEL_GUN_TOOTH_LENGTH);
		var outer_points : PackedVector2Array = System.Styles.generate_serrated_rect_points(outer_rect, segment_counts, POWER_PANEL_GUN_TOOTH_OUT_DEPTH, POWER_PANEL_GUN_TOOTH_IN_DEPTH);
		power_panel_gun_back.polygon = outer_points;
		power_panel_gun_front.polygon = System.Styles.inset_polygon_points(outer_points, POWER_PANEL_BORDER_WIDTH);
		power_panel_gun_front.color = Color(bg_color);

func update_footer() -> void:
	var type_icon_x : int;
	var type_icon_texture : Texture = load(TYPE_ICON_PATH % card_data.card_type_name);
	match card_data.card_type:
		CardEnums.CardType.ROCK:
			type_icon_x = TYPE_ICON_ROCK_X;
		CardEnums.CardType.PAPER:
			type_icon_x = TYPE_ICON_PAPER_X;
		CardEnums.CardType.SCISSORS:
			type_icon_x = TYPE_ICON_SCISSORS_X;
		CardEnums.CardType.GUN:
			type_icon_x = TYPE_ICON_GUN_X;
	type_icon.position.x = type_icon_x;
	type_icon.texture = type_icon_texture;
	id_label.text = ID_LABEL_TEXT % str(card_data.card_id).pad_zeros(ID_LABEL_LENGTH);
	type_label.text = CardEnums.TranslateCardType[card_data.card_type];
	credit_label.text = CREDIT_LABEL_TEXT % card_data.release_year;
	

func update_effects() -> void:
	var effects_text : String = card_data.get_effects_text();
	effects_label.position.y = -304 if (card_data.keywords.size() == 1 and card_data.has_title) else -324;
	effects_label.text = effects_text;
	effects_label.position.y += 12 if card_data.text_down or effects_label.get_line_count() > 5 else 0;
	effects_label.add_theme_color_override("default_color", Color.BLACK if card_data.black_text else Color.WHITE);
	effects_label.add_theme_color_override("font_outline_color", Color.WHITE if card_data.black_text else Color.BLACK);
	effects_label.add_theme_font_override("normal_font", load(EFFECTS_BOLD_FONT_PATH));
	gravestone_icon.visible = card_data.has_grave_effect;

func update_outer_layer() -> void:
	var style : StyleBoxFlat = StyleBoxFlat.new();
	style.bg_color = OUTER_LAYER_COLOR;
	if Config.PRINT_MODE:
		outer_layer.size = OUTER_LAYER_PRINT_SCALE;
	else:
		outer_layer.size = OUTER_LAYER_BASE_SCALE;
		System.Styles.set_all_corners(style, OUTER_LAYER_CORNER_RADIUS);
	outer_layer.position = -outer_layer.size / 2;
	outer_layer.add_theme_stylebox_override("panel", style);
