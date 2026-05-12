extends StatBar

@onready var name_label : Label = $NameLabel;

func _on_set_name(new_name : String) -> void:
	name_label.text = new_name;
