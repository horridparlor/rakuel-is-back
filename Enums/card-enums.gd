extends Node

enum CardType {
	ROCK,
	PAPER,
	SCISSORS
}

func translate_type(type_string : String) -> CardType:
	match type_string:
		"rock":
			return CardType.ROCK;
		"paper":
			return CardType.PAPER;
		"scissors":
			return CardType.SCISSORS;
	return CardType.ROCK;
