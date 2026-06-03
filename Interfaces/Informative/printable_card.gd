extends Node2D
class_name PrintableCard

const INNER_PANEL_COLOR_ROCK : String = "#398f5b";
const INNER_PANEL_COLOR_PAPER : String = "#2499c8";
const INNER_PANEL_COLOR_SCISSORS : String = "#f7793e";
const INNER_PANEL_CORNER_RADIUS : int = 45;

const POWER_PANEL_COLOR_ROCK : String = "#1e5b46";
const POWER_PANEL_COLOR_PAPER : String = "#14519d";
const POWER_PANEL_COLOR_SCISSORS : String = "#bf3c29";
const POWER_PANEL_CORNER_RADIUS : int = 33;
const POWER_PANEL_ROCK_CORNER_RADIUS : int = 45;
const POWER_PANEL_BORDER_WIDTH : int = 8;
const POWER_PANEL_ZERO_WIDTH : int = 200;
const POWER_PANEL_THOUSAND_WIDTH : int = 470;
const POWER_PANEL_TEN_THOUSAND_WIDTH : int = 500;

const CARD_ART_PATH : String = "res://Assets/Art/CardArt/%s - %s.png";
const ID_LABEL_TEXT : String = "#%s";
const CREDIT_LABEL_TEXT : String = "©%s Eero Laine";
const ID_LABEL_LENGTH : int = 6;

var card_data : CardData;

func load_card_data(card_id : int):
	card_data = CardData.new(card_id);
	update_visuals();

func update_visuals() -> void:
	pass;
