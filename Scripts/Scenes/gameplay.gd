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
	spawn_summon_slots(player);
	for character in player.party:
		spawn_a_character(character);
	
func spawn_summon_slots(player : Player) -> void:
	for i in range(3):
		spawn_summon_slot(i - 1, player.side);

func spawn_summon_slot(y : int = 0, side : Player.Side = Player.Side.LEFT) -> void:
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
	if side == Player.Side.LEFT:
		x_pos = -x_pos;
	slot.position = Vector2(x_pos, y_pos);

func spawn_a_character(character_data : CharacterData) -> void:
	var character : Character = System.Instance.load_child(System.Paths.Characters.BLUE_SLIME, characters_layer);
	character.position = SLOT_MID_POS;
	character.position.x = -character.position.x;
