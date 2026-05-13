extends AttackButton

@onready var attack_name_label : Label = $AttackNameLabel;

func _ready() -> void:
	activate_animations();

func _on_set_name(attack_name : String) -> void:
	attack_name_label.text = attack_name;
