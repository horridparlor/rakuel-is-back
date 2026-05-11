extends Gameplay

@onready var background_layer : Node2D = $Background;
@onready var characters_layer : Node2D = $Characters;

func _ready() -> void:
	init_players();

func init_players() -> void:
	player1 = Player.new(Player.Side.LEFT);
	spawn_characters(player1);
	player2 = Player.new(Player.Side.RIGHT);
	spawn_characters(player2);

func spawn_characters(player : Player) -> void:
	var y : int = -1;
	spawn_summon_slots(player);
	for character in player.party:
		spawn_a_character(character, y);
		y += 1;
		if y > 1:
			break;
	
func spawn_summon_slots(player : Player) -> void:
	for i in range(3):
		spawn_summon_slot(i - 1, player.side);

func spawn_summon_slot(y : int = 0, side : Player.Side = Player.Side.LEFT) -> void:
	var slot : SummonSlot = System.Instance.load_child(System.Paths.Decorations.SUMMON_SLOT, background_layer);
	var x_pos : int = get_summon_slot_x_pos(side, y);
	var y_pos : int = get_summon_slot_y_pos(y);
	slot.position = Vector2(x_pos, y_pos);

func get_summon_slot_x_pos(side : Player.Side = Player.Side.LEFT, y : int = 0) -> int:
	var x_pos : int = SLOT_EDGE_POS.x;
	if y == 0:
		x_pos = SLOT_MID_POS.x;
	if side == Player.Side.LEFT:
		x_pos = -x_pos;
	return x_pos;

func get_summon_slot_y_pos(y : int) -> int:
	match y:
		-1:
			return -SLOT_EDGE_POS.y;
		0:
			return SLOT_MID_POS.y;
		1:
			return SLOT_EDGE_POS.y;
	return 0;

func spawn_a_character(character_data : CharacterData, y : int = 0) -> void:
	var character : Character = System.Instance.load_child(System.Paths.Characters.BLUE_SLIME, characters_layer);
	var x_pos : int = get_summon_slot_x_pos(character_data.player.side, y);
	var y_pos : int = get_summon_slot_y_pos(y);
	character.position = Vector2(x_pos, y_pos);
