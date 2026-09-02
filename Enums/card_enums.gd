extends Node

const KEYWORD_STRING : String = "[center]%s [font_size=%s][i][%s][/i][/font_size][/b]\n[font_size=%s]%s[/font_size][/center]";
const KEYWORD_REMINDLESS_STRING : String = "[center]%s [font_size=%s][i][%s][/i][/font_size][/b]";
const TITLE_STRING : String = "[center][font_size=%s][u][i]%s[/i][/u][/font_size][/center]";
const KEYWORD_DASHED_NAME_STRING : String = "[font_size=%s][i]%s[/i][/font_size][b]%s";

enum CardType {
	ROCK,
	PAPER,
	SCISSORS,
	GUN
}

const TranslateCardType : Dictionary = {
	CardType.ROCK: "Rock",
	CardType.PAPER: "Paper",
	CardType.SCISSORS: "Scissors",
	CardType.GUN: "Gun"
}

const GRAVE_EFFECT_TAGS : Dictionary = {
	KeywordTag.FROM_GRAVE: null,
	KeywordTag.RESHUFFLE_THIS: null,
	KeywordTag.WHEN_RESHUFFLED: null,
}

func translate_type(type_string : String) -> CardType:
	match type_string:
		"rock":
			return CardType.ROCK;
		"paper":
			return CardType.PAPER;
		"scissors":
			return CardType.SCISSORS;
		"gun":
			return CardType.GUN;
	return CardType.ROCK;

enum Keyword {
	AUTOCRACY,
	COMMUNISM,
	COUGAR,
	COUGAR_MAGNET,
	CULTISM,
	DEMOCRACY,
	DIVINE,
	ELDER_SLIME,
	EQUAL_EXCHANGE,
	EXAM,
	FACISM,
	FLUSH,
	GREED,
	HERWOOD,
	INFINITY,
	JUST_OK,
	LITTLE_SISTER,
	MAGIC_POTION,
	MAKKARA,
	MAKKARAJARVI,
	MEGA_GREED,
	MIC_PASS,
	MIKONTALO,
	MINER,
	MONARCHY,
	NATURAL_SELECTION,
	NECROMANCY,
	POVERTY,
	REPLICATE,
	RIZZ,
	SAHKOTALO,
	SINFUL,
	SISTER_VIRUS,
	SLIME,
	SPIRIT_DRAGON,
	SUCK,
	SUS,
	TELEPORTATION,
	TRUMP_CARD,
	WANDERRET,
	WATCH_QUICK,
	WIZARD,
	ZOMBIE
}

enum KeywordTag {
	DECK_BUILDING,
	DISCARD_FROM_HAND,
	FROM_GRAVE,
	FROM_HAND,
	IF_A_FACE_DOWN_CARD,
	IF_DISCARDED,
	OPPONENT_PASSES,
	RESHUFFLE_THIS,
	START_OF_ROUND,
	STATIC,
	TITLE,
	WHEN_EVOLVES,
	WHEN_PLAYED,
	WHEN_RESHUFFLED,
	WHEN_SUPPORTING
}

const KeywordTagNames : Dictionary = {
	KeywordTag.DECK_BUILDING: "Deck building",
	KeywordTag.DISCARD_FROM_HAND: "Discard from hand",
	KeywordTag.FROM_GRAVE: "From grave",
	KeywordTag.FROM_HAND: "From hand",
	KeywordTag.IF_A_FACE_DOWN_CARD: "If a face-down card",
	KeywordTag.IF_DISCARDED: "If discarded",
	KeywordTag.OPPONENT_PASSES: "Opponent passes",
	KeywordTag.RESHUFFLE_THIS: "Reshuffle this",
	KeywordTag.START_OF_ROUND: "Start of round",
	KeywordTag.STATIC: "Static",
	KeywordTag.TITLE: "Title",
	KeywordTag.WHEN_EVOLVES: "When evolves",
	KeywordTag.WHEN_PLAYED: "When played",
	KeywordTag.WHEN_RESHUFFLED: "When reshuffled",
	KeywordTag.WHEN_SUPPORTING: "When supporting"
}

const KeywordNames : Dictionary = {
	Keyword.AUTOCRACY: "Autocracy",
	Keyword.COMMUNISM: "Communism",
	Keyword.COUGAR: "Cougar",
	Keyword.COUGAR_MAGNET: "Cougar-Magnet",
	Keyword.CULTISM: "Cultism",
	Keyword.DEMOCRACY: "Democracy",
	Keyword.DIVINE: "Divine",
	Keyword.ELDER_SLIME: "Elder-Slime",
	Keyword.EQUAL_EXCHANGE: "Equal Exchange",
	Keyword.EXAM: "Exam",
	Keyword.FACISM: "Facism",
	Keyword.FLUSH: "Flush",
	Keyword.GREED: "Greed",
	Keyword.HERWOOD: "Herwood",
	Keyword.INFINITY: "Infinity",
	Keyword.JUST_OK: "Just Ok",
	Keyword.LITTLE_SISTER: "Little Sister",
	Keyword.MAGIC_POTION: "Magic Potion",
	Keyword.MAKKARA: "Makkara",
	Keyword.MAKKARAJARVI: "Makkarajärvi",
	Keyword.MEGA_GREED: "Mega-Greed",
	Keyword.MIC_PASS: "Mic Pass!",
	Keyword.MIKONTALO: "Mikontalo",
	Keyword.MINER: "Miner",
	Keyword.MONARCHY: "Monarchy",
	Keyword.NATURAL_SELECTION: "Natural Selection",
	Keyword.NECROMANCY: "Necromancy",
	Keyword.POVERTY: "Poverty",
	Keyword.REPLICATE: "Replicate",
	Keyword.RIZZ: "Rizz",
	Keyword.SAHKOTALO: "Sähkötalo",
	Keyword.SINFUL: "Sinful",
	Keyword.SISTER_VIRUS: "Sister Virus",
	Keyword.SLIME: "Slime",
	Keyword.SPIRIT_DRAGON: "Spirit Dragon",
	Keyword.SUCK: "Suck",
	Keyword.SUS: "Sus",
	Keyword.TELEPORTATION: "Teleporation",
	Keyword.TRUMP_CARD: "Trump Card",
	Keyword.WANDERRET: "Wanderret",
	Keyword.WATCH_QUICK: "Watch Quick!",
	Keyword.WIZARD: "Wizard",
	Keyword.ZOMBIE: "Zombie"
}

const KeywordCodes : Dictionary = {
	Keyword.AUTOCRACY: "autocracy",
	Keyword.COMMUNISM: "communism",
	Keyword.COUGAR: "cougar",
	Keyword.COUGAR_MAGNET: "cougar-magnet",
	Keyword.CULTISM: "cultism",
	Keyword.DEMOCRACY: "democracy",
	Keyword.DIVINE: "divine",
	Keyword.ELDER_SLIME: "elder-slime",
	Keyword.EQUAL_EXCHANGE: "equal-exchange",
	Keyword.EXAM: "exam",
	Keyword.FACISM: "facism",
	Keyword.FLUSH: "flush",
	Keyword.GREED: "greed",
	Keyword.HERWOOD: "herwood",
	Keyword.INFINITY: "infinity",
	Keyword.JUST_OK: "just-ok",
	Keyword.LITTLE_SISTER: "little-sister",
	Keyword.MAGIC_POTION: "magic-potion",
	Keyword.MAKKARA: "makkara",
	Keyword.MAKKARAJARVI: "makkarajarvi",
	Keyword.MEGA_GREED: "mega-greed",
	Keyword.MIC_PASS: "mic-pass",
	Keyword.MIKONTALO: "mikontalo",
	Keyword.MINER: "miner",
	Keyword.MONARCHY: "monarchy",
	Keyword.NATURAL_SELECTION: "natural-selection",
	Keyword.NECROMANCY: "necromancy",
	Keyword.POVERTY: "poverty",
	Keyword.REPLICATE: "replicate",
	Keyword.RIZZ: "rizz",
	Keyword.SAHKOTALO: "sahkotalo",
	Keyword.SINFUL: "sinful",
	Keyword.SISTER_VIRUS: "sister-virus",
	Keyword.SLIME: "slime",
	Keyword.SPIRIT_DRAGON: "spirit-dragon",
	Keyword.SUCK: "suck",
	Keyword.SUS: "sus",
	Keyword.TELEPORTATION: "teleportation",
	Keyword.TRUMP_CARD: "trump-card",
	Keyword.WANDERRET: "wanderret",
	Keyword.WATCH_QUICK: "watch-quick",
	Keyword.WIZARD: "wizard",
	Keyword.ZOMBIE: "zombie"
}

const TranslateKeyword : Dictionary = {
	"autocracy": Keyword.AUTOCRACY,
	"communism": Keyword.COMMUNISM,
	"cougar": Keyword.COUGAR,
	"cougar-magnet": Keyword.COUGAR_MAGNET,
	"cultism": Keyword.CULTISM,
	"democracy": Keyword.DEMOCRACY,
	"divine": Keyword.DIVINE,
	"elder-slime": Keyword.ELDER_SLIME,
	"equal-exchange": Keyword.EQUAL_EXCHANGE,
	"exam": Keyword.EXAM,
	"facism": Keyword.FACISM,
	"flush": Keyword.FLUSH,
	"greed": Keyword.GREED,
	"herwood": Keyword.HERWOOD,
	"infinity": Keyword.INFINITY,
	"just-ok": Keyword.JUST_OK,
	"little-sister": Keyword.LITTLE_SISTER,
	"magic-potion": Keyword.MAGIC_POTION,
	"makkara": Keyword.MAKKARA,
	"makkarajarvi": Keyword.MAKKARAJARVI,
	"mega-greed": Keyword.MEGA_GREED,
	"mic-pass": Keyword.MIC_PASS,
	"mikontalo": Keyword.MIKONTALO,
	"miner": Keyword.MINER,
	"monarchy": Keyword.MONARCHY,
	"natural-selection": Keyword.NATURAL_SELECTION,
	"necromancy": Keyword.NECROMANCY,
	"poverty": Keyword.POVERTY,
	"replicate": Keyword.REPLICATE,
	"rizz": Keyword.RIZZ,
	"sahkotalo": Keyword.SAHKOTALO,
	"sinful": Keyword.SINFUL,
	"sister-virus": Keyword.SISTER_VIRUS,
	"slime": Keyword.SLIME,
	"spirit-dragon": Keyword.SPIRIT_DRAGON,
	"suck": Keyword.SUCK,
	"sus": Keyword.SUS,
	"teleportation": Keyword.TELEPORTATION,
	"trump-card": Keyword.TRUMP_CARD,
	"wanderret": Keyword.WANDERRET,
	"watch-quick": Keyword.WATCH_QUICK,
	"wizard": Keyword.WIZARD,
	"zombie": Keyword.ZOMBIE
}

const KeywordDescriptions : Dictionary = {
	Keyword.AUTOCRACY: "Any card can devolve into this.",
	Keyword.COMMUNISM: "Replace your bottom prize card with this card. While there, you can draw from opponent’s deck.",
	Keyword.COUGAR: "...a card with 5 000 or less power, draw a card.",
	Keyword.COUGAR_MAGNET: "When a cougar supports this card, draw an additional card.",
	Keyword.CULTISM: "You can reshuffle all 7 little sisters, then draw a prize card.",
	Keyword.DEMOCRACY: "Gains the combined power of all cards supporting this card.",
	Keyword.DIVINE: "Defeats any face-down card.",
	Keyword.ELDER_SLIME: "...from a non-elder slime, opponent discards 2 cards.",
	Keyword.EQUAL_EXCHANGE: "Opponent discards a card.",
	Keyword.EXAM: "Opponent guesses the type of the top card of your deck. Then, mill it.\n[b]•[/b] Right guess, they draw a card.\n[b]•[/b] Wrong guess, they discard a card.",
	Keyword.FACISM: "If they pass with %WEAK_TYPE with 5 000 or less power, destroy all %WEAK_TYPES.",
	Keyword.FLUSH: "...%SAME_TYPE, you may purge %STRONG_TYPE from any grave.",
	Keyword.GREED: "Discard this card, your dice result is increased by 2.",
	Keyword.HERWOOD: "Look at the top 3 cards of your deck, and devolve this into 1 of them. If you do, add the other 2 into your hand.",
	Keyword.INFINITY: "While fully supported, this card gains infinite power.",
	Keyword.JUST_OK: "Draw a card, discard a card.",
	Keyword.LITTLE_SISTER: "The little sister of",
	Keyword.MAGIC_POTION: "Roll a D6. If 1, destroy this card. If 6, draw a card.",
	Keyword.MAKKARA: "Makkara",
	Keyword.MAKKARAJARVI: "You may return a card supporting this to hand. If it was a makkara, you may discard it and draw a card.",
	Keyword.MEGA_GREED: "Discard hand, dice result increased by 1 for every 2 cards discarded.",
	Keyword.MIC_PASS: "You may reshuffle %SAME_TYPE.",
	Keyword.MIKONTALO: "You may return this card from field to hand. If you do, discard a card.",
	Keyword.MINER: "...on an empty stack, mill 2. Draw a card for each rock milled. For each miner milled, repeat this process.",
	Keyword.MONARCHY: "Cannot evolve. Defeats any %WEAK_TYPE with more power.",
	Keyword.NATURAL_SELECTION: "Discard this card. This round, each player can only play one more card. Those cards are played face-down.",
	Keyword.NECROMANCY: "You may play a zombie from your grave supporting this.",
	Keyword.POVERTY: "To evolve this, discard a card.",
	Keyword.REPLICATE: "Unlimited copies of this card.",
	Keyword.RIZZ: "Opponent may discard a card to negate your rizz. If they don't, reveal one of their face-down cards.",
	Keyword.SAHKOTALO: "You may discard up to 2 cards. If you do, retrigger the effects of up to that many cards supporting this card.",
	Keyword.SINFUL: "...from a card with 2 000 or less power, mill 2. Opponent discards a card for each scissors milled.",
	Keyword.SISTER_VIRUS: "This card may evolve into any little sister in your grave.",
	Keyword.SLIME: "Slime",
	Keyword.SPIRIT_DRAGON: "The spirit dragon of",
	Keyword.SUCK: "If opponent has full field, you may discard this. If you do, destroy field.",
	Keyword.SUS: "...would be revealed, you may reveal this card from your hand instead.",
	Keyword.TELEPORTATION: "You may replace your primary card with this card from your hand. If you do, discard either %WEAK_TYPE or 2 cards.",
	Keyword.TRUMP_CARD: "While you have 5 or less cards in hand, you may discard this card. If you do, negate all lingering effects. Also, reveal all face-down cards.",
	Keyword.WANDERRET: "...a wanderret, draw a card.",
	Keyword.WATCH_QUICK: "Reveal target face-down card.",
	Keyword.WIZARD: "Can evolve into any card, but play that card face-down.",
	Keyword.ZOMBIE: "Zombie"
}

const KeywordTags : Dictionary = {
	Keyword.AUTOCRACY: KeywordTag.STATIC,
	Keyword.COMMUNISM: KeywordTag.FROM_HAND,
	Keyword.COUGAR: KeywordTag.WHEN_SUPPORTING,
	Keyword.COUGAR_MAGNET: KeywordTag.STATIC,
	Keyword.CULTISM: KeywordTag.FROM_GRAVE,
	Keyword.DEMOCRACY: KeywordTag.STATIC,
	Keyword.DIVINE: KeywordTag.STATIC,
	Keyword.ELDER_SLIME: KeywordTag.WHEN_EVOLVES,
	Keyword.EQUAL_EXCHANGE: KeywordTag.IF_DISCARDED,
	Keyword.EXAM: KeywordTag.WHEN_PLAYED,
	Keyword.FACISM: KeywordTag.OPPONENT_PASSES,
	Keyword.FLUSH: KeywordTag.WHEN_SUPPORTING,
	Keyword.GREED: KeywordTag.START_OF_ROUND,
	Keyword.HERWOOD: KeywordTag.OPPONENT_PASSES,
	Keyword.INFINITY: KeywordTag.STATIC,
	Keyword.JUST_OK: KeywordTag.WHEN_RESHUFFLED,
	Keyword.LITTLE_SISTER: KeywordTag.TITLE,
	Keyword.MAGIC_POTION: KeywordTag.WHEN_PLAYED,
	Keyword.MAKKARA: KeywordTag.TITLE,
	Keyword.MAKKARAJARVI: KeywordTag.WHEN_PLAYED,
	Keyword.MEGA_GREED: KeywordTag.START_OF_ROUND,
	Keyword.MIC_PASS: KeywordTag.OPPONENT_PASSES,
	Keyword.MIKONTALO: KeywordTag.OPPONENT_PASSES,
	Keyword.MINER: KeywordTag.WHEN_PLAYED,
	Keyword.MONARCHY: KeywordTag.STATIC,
	Keyword.NATURAL_SELECTION: KeywordTag.START_OF_ROUND,
	Keyword.NECROMANCY: KeywordTag.WHEN_PLAYED,
	Keyword.POVERTY: KeywordTag.STATIC,
	Keyword.REPLICATE: KeywordTag.DECK_BUILDING,
	Keyword.RIZZ: KeywordTag.DISCARD_FROM_HAND,
	Keyword.SAHKOTALO: KeywordTag.WHEN_PLAYED,
	Keyword.SINFUL: KeywordTag.WHEN_EVOLVES,
	Keyword.SISTER_VIRUS: KeywordTag.STATIC,
	Keyword.SLIME: KeywordTag.TITLE,
	Keyword.SPIRIT_DRAGON: KeywordTag.TITLE,
	Keyword.SUCK: KeywordTag.FROM_HAND,
	Keyword.SUS: KeywordTag.IF_A_FACE_DOWN_CARD,
	Keyword.TELEPORTATION: KeywordTag.OPPONENT_PASSES,
	Keyword.TRUMP_CARD: KeywordTag.FROM_HAND,
	Keyword.WANDERRET: KeywordTag.WHEN_SUPPORTING,
	Keyword.WATCH_QUICK: KeywordTag.RESHUFFLE_THIS,
	Keyword.WIZARD: KeywordTag.STATIC,
	Keyword.ZOMBIE: KeywordTag.TITLE
}

func is_title_keyword(keyword : Keyword) -> bool:
	return KeywordTags[keyword] == KeywordTag.TITLE;

func is_keyword_grave_effect(keyword : Keyword) -> bool:
	return GRAVE_EFFECT_TAGS.has(KeywordTags[keyword]);

func is_long_keyword(keyword : Keyword) -> bool:
	return KeywordDescriptions[keyword].length() > 80;

func get_keyword_text(keyword : Keyword, card_type : CardType = CardType.ROCK, hide_reminder : bool = false, is_only_keyword : bool = false) -> String:
	var keyword_name : String = KeywordNames[keyword];
	var tag_name : String = KeywordTagNames[KeywordTags[keyword]];
	var description : String = enrich_keyword_description(KeywordDescriptions[keyword], card_type);
	var title_font_size : int = 40 if keyword_name.length() + tag_name.length() > 25 else 48;
	var font_size : int = 40 if description.length() > 64 else 48;
	var formatted_name : String = "[b]%s" % keyword_name;
	if "-" in keyword_name:
		var dash_idx = keyword_name.find("-");
		formatted_name = KEYWORD_DASHED_NAME_STRING % [title_font_size, keyword_name.substr(0, dash_idx + 1), keyword_name.substr(dash_idx + 1)];
	if is_title_keyword(keyword):
		font_size = 48 if is_only_keyword else 40;
		return TITLE_STRING % [font_size, description];
	if hide_reminder:
		return KEYWORD_REMINDLESS_STRING % [
			formatted_name,
			title_font_size,
			tag_name,
		];
	return KEYWORD_STRING % [
		formatted_name,
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
