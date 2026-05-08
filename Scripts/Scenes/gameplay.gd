extends Gameplay

@onready var background_layer : Node2D = $Background;
@onready var characters_layer : Node2D = $Characters;

func _ready() -> void:
	summon_characters();

func summon_characters() -> void:
	spawn_summon_slots();
	
func spawn_summon_slots() -> void:
	for i in range(3):
		spawn_summon_slot(i - 1);
		spawn_summon_slot(i - 1, true);

func spawn_summon_slot(y : int = 0, for_opponent : bool = false) -> void:
	var slot : SummonSlot = System.Instance.load_child(System.Paths.Decorations.SUMMON_SLOT, background_layer);
	var x_pos : int = SLOT_EDGE_POS.x;
	var y_pos : int = SLOT_MID_POS.y;
	match y:
		-1:
			y_pos = -SLOT_EDGE_POS.y;
		0:
			x_pos = SLOT_MID_POS.x;
		1:
			y_pos = SLOT_EDGE_POS.y;
	if !for_opponent:
		x_pos = -x_pos;
	slot.position = Vector2(x_pos, y_pos);
