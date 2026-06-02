extends Node2D
class_name PrintableCard

const INNER_PANEL_COLOR_ROCK : String = "#398f5b";
const INNER_PANEL_COLOR_PAPER : String = "#2499c8";
const INNER_PANEL_COLOR_SCISSORS : String = "#f7793e";
const INNER_PANEL_CORNER_RADIUS : int = 45;

var card_data : CardData;

func load_card_data(card_id : int):
	card_data = CardData.new(card_id);
	update_visuals();

func update_visuals() -> void:
	pass;
