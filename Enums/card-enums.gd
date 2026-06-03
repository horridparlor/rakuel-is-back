extends Node

const KEYWORD_STRING : String = "[center][b]%s [i][%s][/i][/b]\n%s[/center]";

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

enum Keyword {
	COUGAR,
	DIVINE,
	GREED,
	LITTLE_SISTER_OF_AUTOCRACY,
	LITTLE_SISTER_OF_COMMUNISM,
	LITTLE_SISTER_OF_CULTISM,
	LITTLE_SISTER_OF_DEMOCRACY,
	LITTLE_SISTER_OF_FACISM,
	LITTLE_SISTER_OF_MONARCHY,
	LITTLE_SISTER_OF_NATURAL_SELECTION,
	MAGIC_POTION,
	REPLICATE,
	SISTER_VIRUS,
	WANDERRET,
	WIZARD
}

enum KeywordTag {
	START_OF_TURN,
	STATIC
}

const KeywordTagNames : Dictionary = {
	KeywordTag.START_OF_TURN: "Start of turn",
	KeywordTag.STATIC: "Static"
}

const KeywordNames : Dictionary = {
	Keyword.COUGAR: "Cougar",
	Keyword.DIVINE: "Divine",
	Keyword.GREED: "Greed",
	Keyword.LITTLE_SISTER_OF_AUTOCRACY: "The little sister of\nAutocracy",
	Keyword.LITTLE_SISTER_OF_COMMUNISM: "The little sister of\nCommunism",
	Keyword.LITTLE_SISTER_OF_CULTISM: "The little sister of\nCultism",
	Keyword.LITTLE_SISTER_OF_DEMOCRACY: "The little sister of\nDemocracy",
	Keyword.LITTLE_SISTER_OF_FACISM: "The little sister of\nFacism",
	Keyword.LITTLE_SISTER_OF_MONARCHY: "The little sister of\nMonarchy",
	Keyword.LITTLE_SISTER_OF_NATURAL_SELECTION: "The little sister of\nNatural Selection",
	Keyword.MAGIC_POTION: "Magic Potion",
	Keyword.REPLICATE: "Replicate",
	Keyword.SISTER_VIRUS: "Sister Virus",
	Keyword.WANDERRET: "Wanderret",
	Keyword.WIZARD: "Wizard"
}

const KeywordCodes : Dictionary = {
	Keyword.COUGAR: "cougar",
	Keyword.DIVINE: "divine",
	Keyword.GREED: "greed",
	Keyword.LITTLE_SISTER_OF_AUTOCRACY: "little-sister-of-autocracy",
	Keyword.LITTLE_SISTER_OF_COMMUNISM: "little-sister-of-communism",
	Keyword.LITTLE_SISTER_OF_CULTISM: "little-sister-of-cultism",
	Keyword.LITTLE_SISTER_OF_DEMOCRACY: "little-sister-of-democracy",
	Keyword.LITTLE_SISTER_OF_FACISM: "little-sister-of-facism",
	Keyword.LITTLE_SISTER_OF_MONARCHY: "little-sister-of-monarchy",
	Keyword.LITTLE_SISTER_OF_NATURAL_SELECTION: "little-sister-of-natural-selection",
	Keyword.MAGIC_POTION: "magic-potion",
	Keyword.REPLICATE: "replicate",
	Keyword.SISTER_VIRUS: "sister-virus",
	Keyword.WANDERRET: "wanderret",
	Keyword.WIZARD: "wizard"
}

const TranslateKeyword : Dictionary = {
	"cougar": Keyword.COUGAR,
	"divine": Keyword.DIVINE,
	"greed": Keyword.GREED,
	"little-sister-of-autocracy": Keyword.LITTLE_SISTER_OF_AUTOCRACY,
	"little-sister-of-communism": Keyword.LITTLE_SISTER_OF_COMMUNISM,
	"little-sister-of-cultism": Keyword.LITTLE_SISTER_OF_CULTISM,
	"little-sister-of-democracy": Keyword.LITTLE_SISTER_OF_DEMOCRACY,
	"little-sister-of-facism": Keyword.LITTLE_SISTER_OF_FACISM,
	"little-sister-of-monarchy": Keyword.LITTLE_SISTER_OF_MONARCHY,
	"little-sister-of-natural-selection": Keyword.LITTLE_SISTER_OF_NATURAL_SELECTION,
	"magic-potion": Keyword.MAGIC_POTION,
	"replicate": Keyword.REPLICATE,
	"sister-virus": Keyword.SISTER_VIRUS,
	"wanderret": Keyword.WANDERRET,
	"wizard": Keyword.WIZARD
}

const KeywordDescriptions : Dictionary = {
	Keyword.COUGAR: "If you evolve a card with 5000 or less power into this, draw a card.",
	Keyword.DIVINE: "Defeats any fade-down card.",
	Keyword.GREED: "Discard this card, your dice result is increased by 2.",
	Keyword.LITTLE_SISTER_OF_AUTOCRACY: "Any card can devolve into this card.",
	Keyword.LITTLE_SISTER_OF_COMMUNISM: "Replace your bottom price card with this. While there, you can draw from opponent’s deck.",
	Keyword.LITTLE_SISTER_OF_CULTISM: "You can reshuffle all 7 little sisters, and draw a price card.",
	Keyword.LITTLE_SISTER_OF_DEMOCRACY: "Gains the combined power of all rocks in your grave.",
	Keyword.LITTLE_SISTER_OF_FACISM: "Hand trap, if opponent plays a rock with 5000 or less power, destroy it.",
	Keyword.LITTLE_SISTER_OF_MONARCHY: "Cannot evolve. Defeats any card with more power.",
	Keyword.LITTLE_SISTER_OF_NATURAL_SELECTION: "This turn, each player only plays one card face down.",
	Keyword.MAGIC_POTION: "Roll a D6. If 1, destroy this card. If 6, draw a card.",
	Keyword.REPLICATE: "You can any number of copies of this card in your deck.",
	Keyword.SISTER_VIRUS: "This card may evolve into any little sister in your grave.",
	Keyword.WANDERRET: "May devolve into any Wanderret.",
	Keyword.WIZARD: "Can evolve into any card, but face-down."
}

const KeywordTags : Dictionary = {
	Keyword.COUGAR: KeywordTag.STATIC,
	Keyword.DIVINE: KeywordTag.STATIC,
	Keyword.GREED: KeywordTag.START_OF_TURN,
	Keyword.LITTLE_SISTER_OF_AUTOCRACY: KeywordTag.STATIC,
	Keyword.LITTLE_SISTER_OF_COMMUNISM: KeywordTag.STATIC,
	Keyword.LITTLE_SISTER_OF_CULTISM: KeywordTag.STATIC,
	Keyword.LITTLE_SISTER_OF_DEMOCRACY: KeywordTag.STATIC,
	Keyword.LITTLE_SISTER_OF_FACISM: KeywordTag.STATIC,
	Keyword.LITTLE_SISTER_OF_MONARCHY: KeywordTag.STATIC,
	Keyword.LITTLE_SISTER_OF_NATURAL_SELECTION: KeywordTag.STATIC,
	Keyword.MAGIC_POTION: KeywordTag.STATIC,
	Keyword.REPLICATE: KeywordTag.STATIC,
	Keyword.SISTER_VIRUS: KeywordTag.STATIC,
	Keyword.WANDERRET: KeywordTag.STATIC,
	Keyword.WIZARD: KeywordTag.STATIC,
}

func get_keyword_text(keyword : Keyword) -> String:
	return KEYWORD_STRING % [
		KeywordNames[keyword],
		KeywordTagNames[KeywordTags[keyword]],
		KeywordDescriptions[keyword]
	];
