extends PrintableCard

@onready var outer_layer : Panel = $OuterLayer;
@onready var inner_layer : Panel = $InnerLayer;
@onready var name_label : Label = $NameLabel;
@onready var power_label : Label = $PowerLabel;

func update_visuals() -> void:
	name_label.text = card_data.card_name;
	power_label.text = ("%s 000" if card_data.power > 0 else "%s") % str(card_data.power / 1000);
