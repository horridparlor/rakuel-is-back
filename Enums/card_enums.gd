extends Node

const KEYWORD_STRING : String = "[center][b]%s [font_size=%s][i][%s][/i][/font_size][/b]\n[font_size=%s]%s[/font_size][/center]";
const KEYWORD_REMINDLESS_STRING : String = "[center][b]%s [font_size=%s][i][%s][/i][/font_size][/b]";
const TITLE_STRING : String = "[center][u][i]%s[/i][/u][/center]";

enum CardType {
	ROCK,
	PAPER,
	SCISSORS
}

const TranslateCardType : Dictionary = {
	CardType.ROCK: "Rock",
	CardType.PAPER: "Paper",
	CardType.SCISSORS: "Scissors"
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
	COMMUNISM,
	COUGAR,
	CULTISM,
	DEMOCRACY,
	DICTATORSHIP,
	DIVINE,
	FACISM,
	GREED,
	LITTLE_SISTER,
	MAGIC_POTION,
	NATURAL_SELECTION,
	MONARCHY,
	REPLICATE,
	SISTER_VIRUS,
	WANDERRET,
	WIZARD
}

enum KeywordTag {
	DECK_BUILDING,
	FROM_GRAVE,
	ON_YOUR_TURN,
	OPPONENT_PASSES,
	START_OF_TURN,
	STATIC,
	TITLE,
	WHEN_PLAYED,
	WHEN_SUPPORTING
}

const KeywordTagNames : Dictionary = {
	KeywordTag.DECK_BUILDING: "Deck building",
	KeywordTag.FROM_GRAVE: "From grave",
	KeywordTag.ON_YOUR_TURN: "On your turn",
	KeywordTag.OPPONENT_PASSES: "Opponent passes",
	KeywordTag.START_OF_TURN: "Start of turn",
	KeywordTag.STATIC: "Static",
	KeywordTag.TITLE: "Title",
	KeywordTag.WHEN_PLAYED: "When played",
	KeywordTag.WHEN_SUPPORTING: "When supporting"
}

const KeywordNames : Dictionary = {
	Keyword.COMMUNISM: "Communism",
	Keyword.COUGAR: "Cougar",
	Keyword.CULTISM: "Cultism",
	Keyword.DEMOCRACY: "Democracy",
	Keyword.DICTATORSHIP: "Dictatorship",
	Keyword.DIVINE: "Divine",
	Keyword.FACISM: "Facism",
	Keyword.GREED: "Greed",
	Keyword.LITTLE_SISTER: "Little Sister",
	Keyword.MAGIC_POTION: "Magic Potion",
	Keyword.MONARCHY: "Monarchy",
	Keyword.NATURAL_SELECTION: "Natural Selection",
	Keyword.REPLICATE: "Replicate",
	Keyword.SISTER_VIRUS: "Sister Virus",
	Keyword.WANDERRET: "Wanderret",
	Keyword.WIZARD: "Wizard"
}

const KeywordCodes : Dictionary = {
	Keyword.COMMUNISM: "communism",
	Keyword.COUGAR: "cougar",
	Keyword.CULTISM: "cultism",
	Keyword.DEMOCRACY: "democracy",
	Keyword.DICTATORSHIP: "dictatorship",
	Keyword.DIVINE: "divine",
	Keyword.FACISM: "facism",
	Keyword.GREED: "greed",
	Keyword.LITTLE_SISTER: "little-sister",
	Keyword.MAGIC_POTION: "magic-potion",
	Keyword.MONARCHY: "monarchy",
	Keyword.NATURAL_SELECTION: "natural-selection",
	Keyword.REPLICATE: "replicate",
	Keyword.SISTER_VIRUS: "sister-virus",
	Keyword.WANDERRET: "wanderret",
	Keyword.WIZARD: "wizard"
}

const TranslateKeyword : Dictionary = {
	"communism": Keyword.COMMUNISM,
	"cougar": Keyword.COUGAR,
	"cultism": Keyword.CULTISM,
	"democracy": Keyword.DEMOCRACY,
	"dictatorship": Keyword.DICTATORSHIP,
	"divine": Keyword.DIVINE,
	"facism": Keyword.FACISM,
	"greed": Keyword.GREED,
	"little-sister": Keyword.LITTLE_SISTER,
	"magic-potion": Keyword.MAGIC_POTION,
	"monarchy": Keyword.MONARCHY,
	"natural-selection": Keyword.NATURAL_SELECTION,
	"replicate": Keyword.REPLICATE,
	"sister-virus": Keyword.SISTER_VIRUS,
	"wanderret": Keyword.WANDERRET,
	"wizard": Keyword.WIZARD
}

const KeywordDescriptions : Dictionary = {
	Keyword.COMMUNISM: "Replace your bottom price card with this card. While there, you can draw from opponent’s deck.",
	Keyword.COUGAR: "...a card with 5 000 or less power, draw a card.",
	Keyword.CULTISM: "You can reshuffle all 7 little sisters, then draw a price card.",
	Keyword.DEMOCRACY: "Gains the combined power of all %SAME_TYPES in your grave.",
	Keyword.DICTATORSHIP: "Any card can devolve into this.",
	Keyword.DIVINE: "Defeats any fade-down card.",
	Keyword.FACISM: "If they pass with %WEAK_TYPE with 5000 or less power, destroy all %WEAK_TYPES.",
	Keyword.GREED: "Discard this card, your dice result is increased by 2.",
	Keyword.LITTLE_SISTER: "Little sister of",
	Keyword.MAGIC_POTION: "Roll a D6. If 1, destroy this card. If 6, draw a card.",
	Keyword.MONARCHY: "Cannot evolve. Defeats any %WEAK_TYPE with more power.",
	Keyword.NATURAL_SELECTION: "Discard this card. This turn, each player can only play one more card. Those cards are played face-down.",
	Keyword.REPLICATE: "Unlimited copies of this card.",
	Keyword.SISTER_VIRUS: "This card may evolve into any little sister in your grave.",
	Keyword.WANDERRET: "...a wanderret, draw a card.",
	Keyword.WIZARD: "Can evolve into any card, but play that card face-down."
}

const KeywordTags : Dictionary = {
	Keyword.COMMUNISM: KeywordTag.ON_YOUR_TURN,
	Keyword.COUGAR: KeywordTag.WHEN_SUPPORTING,
	Keyword.CULTISM: KeywordTag.FROM_GRAVE,
	Keyword.DEMOCRACY: KeywordTag.STATIC,
	Keyword.DICTATORSHIP: KeywordTag.STATIC,
	Keyword.DIVINE: KeywordTag.STATIC,
	Keyword.FACISM: KeywordTag.OPPONENT_PASSES,
	Keyword.GREED: KeywordTag.START_OF_TURN,
	Keyword.LITTLE_SISTER: KeywordTag.TITLE,
	Keyword.MAGIC_POTION: KeywordTag.WHEN_PLAYED,
	Keyword.MONARCHY: KeywordTag.STATIC,
	Keyword.NATURAL_SELECTION: KeywordTag.START_OF_TURN,
	Keyword.REPLICATE: KeywordTag.DECK_BUILDING,
	Keyword.SISTER_VIRUS: KeywordTag.STATIC,
	Keyword.WANDERRET: KeywordTag.WHEN_SUPPORTING,
	Keyword.WIZARD: KeywordTag.STATIC,
}

func is_title_keyword(keyword : Keyword) -> bool:
	return KeywordTags[keyword] == KeywordTag.TITLE;

func is_long_keyword(keyword : Keyword) -> bool:
	return KeywordDescriptions[keyword].length() > 80;

func get_keyword_text(keyword : Keyword, card_type : CardType = CardType.ROCK, hide_reminder : bool = false) -> String:
	var keyword_name : String = KeywordNames[keyword];
	var tag_name : String = KeywordTagNames[KeywordTags[keyword]];
	var description : String = enrich_keyword_description(KeywordDescriptions[keyword], card_type);
	var title_font_size : int = 44 if keyword_name.length() + tag_name.length() > 28 else 48;
	var font_size : int = 40 if description.length() > 64 else 48;
	if is_title_keyword(keyword):
		return TITLE_STRING % description;
	if hide_reminder:
		return KEYWORD_REMINDLESS_STRING % [
			keyword_name,
			title_font_size,
			tag_name,
		];
	return KEYWORD_STRING % [
		keyword_name,
		title_font_size,
		tag_name,
		font_size,
		description
	];

const ROCK : String = "a rock";
const ROCKS : String = "rocks";
const PAPER : String = "a paper";
const PAPERS : String = "papers";
const SCISSORS : String = "scissors";

func enrich_keyword_description(description : String, card_type : CardType = CardType.ROCK) -> String:
	var same_type : String = "";
	var same_types : String = "";
	var weak_type : String = "";
	var weak_types : String = "";
	var strong_type : String = "";
	var strong_types : String = "";

	match card_type:
		CardType.ROCK:
			same_type = ROCK;
			same_types = ROCKS;
			weak_type = PAPER;
			weak_types = PAPERS;
			strong_type = SCISSORS;
			strong_types = SCISSORS;

		CardType.PAPER:
			same_type = PAPER;
			same_types = PAPERS;
			weak_type = SCISSORS;
			weak_types = SCISSORS;
			strong_type = ROCK;
			strong_types = ROCKS;

		CardType.SCISSORS:
			same_type = SCISSORS;
			same_types = SCISSORS;
			weak_type = ROCK;
			weak_types = ROCKS;
			strong_type = PAPER;
			strong_types = PAPERS;

	return description \
		.replace("%SAME_TYPES", same_types) \
		.replace("%SAME_TYPE", same_type) \
		.replace("%WEAK_TYPES", weak_types) \
		.replace("%WEAK_TYPE", weak_type) \
		.replace("%STRONG_TYPES", strong_types) \
		.replace("%STRONG_TYPE", strong_type);
