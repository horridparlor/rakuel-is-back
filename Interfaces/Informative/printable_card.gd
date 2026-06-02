extends Node2D
class_name PrintableCard

var card_data : CardData;

func load_card_data(card_id : int):
	card_data = CardData.new(card_id);
	update_visuals();

func update_visuals() -> void:
	pass;
