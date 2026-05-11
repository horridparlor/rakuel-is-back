extends Node
class_name Player

enum Side {
	LEFT,
	RIGHT
}

var side : Player.Side
var party : Array;

func _init(_side : Player.Side) -> void:
	side = _side;
	set_party();

func set_party() -> void:
	var character : CharacterData;
	for i in range(3):
		character = CharacterData.new(1);
		character.player = self;
		party.append(character);
