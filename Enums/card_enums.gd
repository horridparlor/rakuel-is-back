extends Node

const KEYWORD_STRING : String = "[center]%s [font=%s][font_size=%s][%s][/font_size][/font]\n[font_size=%s]%s[/font_size][/center]";
const KEYWORD_REMINDLESS_STRING : String = "[center]%s [font=%s][font_size=%s][%s][/font_size][/font]";
const TITLE_STRING : String = "[center][font_size=%s][u][i]%s[/i][/u][/font_size][/center]";
const KEYWORD_DASHED_NAME_STRING : String = "[font_size=%s][i]%s[/i][b]%s[/b][/font_size]";

const TAG_FONT_ITALIC_TEXT_BOLDEN : String = "res://Assets/Fonts/Montserrat/Montserrat-Italic.ttf";
const TAG_FONT_ITALIC_BOLDEN : String = "res://Assets/Fonts/Montserrat/Montserrat-ExtraBoldItalic.ttf";

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

const GRAVE_KEYWORDS : Dictionary = {
	Keyword.ZOMBIE: null
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
	BIG_CHUNGUS,
	CALAMITY,
	CAPITALISM,
	COMMUNISM,
	COPYCAT,
	COUGAR,
	COUGAR_MAGNET,
	CULTISM,
	DEBATING,
	DEMOCRACY,
	DINOSAUR,
	DIVINE,
	ELDER_SLIME,
	EQUAL_EXCHANGE,
	ERUPTION,
	EVERYTHING,
	EXAM,
	FACISM,
	FAM,
	FARMING,
	FATHER,
	FLUSH,
	GREED,
	HERWOOD,
	HUMANITY,
	HUSTLER,
	ICE_CREAM,
	INFINITY,
	JUSTICE,
	JUST_OK,
	KAMIKAZE,
	LITTLE_SISTER,
	LOOT,
	LOTTERY,
	MAGIC_POTION,
	MAKKARA,
	MAKKARAJARVI,
	MEEMIN,
	MEGA_GREED,
	MIC_PASS,
	MIKONTALO,
	MINER,
	MONARCHY,
	MUCH_HIGHER,
	NATURAL_SELECTION,
	NECROMANCY,
	POTENTIAL,
	POVERTY,
	PROPAGATION,
	REPLICATE,
	REVERSE_PSYCHOLOGY,
	RIZZ,
	RUST,
	SAHKOTALO,
	SEEDS,
	SINFUL,
	SISTER_VIRUS,
	SLIME,
	SPIRIT_DRAGON,
	SUCK_THIS,
	SUS,
	SWEDISH,
	TELEPORTATION,
	TRANSFUSION,
	TREASURE,
	TRUMP_CARD,
	TUTOR,
	WAIT_TIME,
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
	IF_FULLY_SUPPORTED,
	OPPONENT_PASSES,
	RESHUFFLE_THIS,
	START_OF_ROUND,
	STATIC,
	TITLE,
	WHEN_EVOLVES,
	WHEN_MILLED,
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
	KeywordTag.IF_FULLY_SUPPORTED: "If fully supported",
	KeywordTag.OPPONENT_PASSES: "Opponent passes",
	KeywordTag.RESHUFFLE_THIS: "Reshuffle this",
	KeywordTag.START_OF_ROUND: "Start of round",
	KeywordTag.STATIC: "Static",
	KeywordTag.TITLE: "Title",
	KeywordTag.WHEN_EVOLVES: "When evolves",
	KeywordTag.WHEN_MILLED: "If milled",
	KeywordTag.WHEN_PLAYED: "When played",
	KeywordTag.WHEN_RESHUFFLED: "When reshuffled",
	KeywordTag.WHEN_SUPPORTING: "When supporting"
}

const KeywordNames : Dictionary = {
	Keyword.AUTOCRACY: "Autocracy",
	Keyword.BIG_CHUNGUS: "Big Chungus",
	Keyword.CALAMITY: "Calamity",
	Keyword.CAPITALISM: "Capitalism",
	Keyword.COMMUNISM: "Communism",
	Keyword.COPYCAT: "Copycat",
	Keyword.COUGAR: "Cougar",
	Keyword.COUGAR_MAGNET: "Cougar-Magnet",
	Keyword.CULTISM: "Cultism",
	Keyword.DEBATING: "Debating",
	Keyword.DEMOCRACY: "Democracy",
	Keyword.DINOSAUR: "Dinosaur",
	Keyword.DIVINE: "Divine",
	Keyword.ELDER_SLIME: "Elder-Slime",
	Keyword.EQUAL_EXCHANGE: "Equal Exchange",
	Keyword.ERUPTION: "Eruption",
	Keyword.EVERYTHING: "Everything",
	Keyword.EXAM: "Exam",
	Keyword.FACISM: "Facism",
	Keyword.FAM: "Fam",
	Keyword.FARMING: "Farming",
	Keyword.FATHER: "Father",
	Keyword.FLUSH: "Flush",
	Keyword.GREED: "Greed",
	Keyword.HERWOOD: "Herwood",
	Keyword.HUMANITY: "Humanity",
	Keyword.HUSTLER: "Hustler",
	Keyword.ICE_CREAM: "Ice Cream",
	Keyword.INFINITY: "Infinity",
	Keyword.JUSTICE: "Justice",
	Keyword.JUST_OK: "Just Ok",
	Keyword.KAMIKAZE: "Kamikaze",
	Keyword.LITTLE_SISTER: "Little Sister",
	Keyword.LOOT: "Loot",
	Keyword.LOTTERY: "Lottery",
	Keyword.MAGIC_POTION: "Magic Potion",
	Keyword.MAKKARA: "Makkara",
	Keyword.MAKKARAJARVI: "Makkarajärvi",
	Keyword.MEEMIN: "Meemin",
	Keyword.MEGA_GREED: "Mega-Greed",
	Keyword.MIC_PASS: "Mic Pass!",
	Keyword.MIKONTALO: "Mikontalo",
	Keyword.MINER: "Miner",
	Keyword.MONARCHY: "Monarchy",
	Keyword.MUCH_HIGHER: "Much Higher!",
	Keyword.NATURAL_SELECTION: "Natural Selection",
	Keyword.NECROMANCY: "Necromancy",
	Keyword.POTENTIAL: "Potential",
	Keyword.POVERTY: "Poverty",
	Keyword.PROPAGATION: "Propagation",
	Keyword.REPLICATE: "Replicate",
	Keyword.REVERSE_PSYCHOLOGY: "Reverse Psychology",
	Keyword.RIZZ: "Rizz",
	Keyword.RUST: "Rust",
	Keyword.SAHKOTALO: "Sähkötalo",
	Keyword.SEEDS: "Seeds",
	Keyword.SINFUL: "Sinful",
	Keyword.SISTER_VIRUS: "Sister Virus",
	Keyword.SLIME: "Slime",
	Keyword.SPIRIT_DRAGON: "Spirit Dragon",
	Keyword.SUCK_THIS: "Suck This!",
	Keyword.SUS: "Sus",
	Keyword.SWEDISH: "Swedish",
	Keyword.TELEPORTATION: "Teleporation",
	Keyword.TRANSFUSION: "Transfusion",
	Keyword.TREASURE: "Treasure",
	Keyword.TRUMP_CARD: "Trump Card",
	Keyword.TUTOR: "Tutor",
	Keyword.WAIT_TIME: "Wait Time",
	Keyword.WANDERRET: "Wanderret",
	Keyword.WATCH_QUICK: "Watch Quick!",
	Keyword.WIZARD: "Wizard",
	Keyword.ZOMBIE: "Zombie"
}

const KeywordCodes : Dictionary = {
	Keyword.AUTOCRACY: "autocracy",
	Keyword.BIG_CHUNGUS: "big-chungus",
	Keyword.CALAMITY: "calamity",
	Keyword.CAPITALISM: "capitalism",
	Keyword.COMMUNISM: "communism",
	Keyword.COPYCAT: "copycat",
	Keyword.COUGAR: "cougar",
	Keyword.COUGAR_MAGNET: "cougar-magnet",
	Keyword.CULTISM: "cultism",
	Keyword.DEBATING: "debating",
	Keyword.DEMOCRACY: "democracy",
	Keyword.DINOSAUR: "dinosaur",
	Keyword.DIVINE: "divine",
	Keyword.ELDER_SLIME: "elder-slime",
	Keyword.EQUAL_EXCHANGE: "equal-exchange",
	Keyword.ERUPTION: "eruption",
	Keyword.EVERYTHING: "everything",
	Keyword.EXAM: "exam",
	Keyword.FACISM: "facism",
	Keyword.FAM: "fam",
	Keyword.FARMING: "farming",
	Keyword.FATHER: "father",
	Keyword.FLUSH: "flush",
	Keyword.GREED: "greed",
	Keyword.HERWOOD: "herwood",
	Keyword.HUMANITY: "humanity",
	Keyword.HUSTLER: "hustler",
	Keyword.ICE_CREAM: "ice-cream",
	Keyword.INFINITY: "infinity",
	Keyword.JUSTICE: "justice",
	Keyword.JUST_OK: "just-ok",
	Keyword.KAMIKAZE: "kamikaze",
	Keyword.LITTLE_SISTER: "little-sister",
	Keyword.LOOT: "loot",
	Keyword.LOTTERY: "lottery",
	Keyword.MAGIC_POTION: "magic-potion",
	Keyword.MAKKARA: "makkara",
	Keyword.MAKKARAJARVI: "makkarajarvi",
	Keyword.MEEMIN: "meemin",
	Keyword.MEGA_GREED: "mega-greed",
	Keyword.MIC_PASS: "mic-pass",
	Keyword.MIKONTALO: "mikontalo",
	Keyword.MINER: "miner",
	Keyword.MONARCHY: "monarchy",
	Keyword.MUCH_HIGHER: "much-higher",
	Keyword.NATURAL_SELECTION: "natural-selection",
	Keyword.NECROMANCY: "necromancy",
	Keyword.POTENTIAL: "potential",
	Keyword.POVERTY: "poverty",
	Keyword.PROPAGATION: "propagation",
	Keyword.REPLICATE: "replicate",
	Keyword.REVERSE_PSYCHOLOGY: "reverse-psychology",
	Keyword.RIZZ: "rizz",
	Keyword.RUST: "rust",
	Keyword.SAHKOTALO: "sahkotalo",
	Keyword.SEEDS: "seeds",
	Keyword.SINFUL: "sinful",
	Keyword.SISTER_VIRUS: "sister-virus",
	Keyword.SLIME: "slime",
	Keyword.SPIRIT_DRAGON: "spirit-dragon",
	Keyword.SUCK_THIS: "suck-this",
	Keyword.SUS: "sus",
	Keyword.SWEDISH: "swedish",
	Keyword.TELEPORTATION: "teleportation",
	Keyword.TRANSFUSION: "transfusion",
	Keyword.TREASURE: "treasure",
	Keyword.TRUMP_CARD: "trump-card",
	Keyword.TUTOR: "tutor",
	Keyword.WAIT_TIME: "wait-time",
	Keyword.WANDERRET: "wanderret",
	Keyword.WATCH_QUICK: "watch-quick",
	Keyword.WIZARD: "wizard",
	Keyword.ZOMBIE: "zombie"
}

const TranslateKeyword : Dictionary = {
	"autocracy": Keyword.AUTOCRACY,
	"big-chungus": Keyword.BIG_CHUNGUS,
	"calamity": Keyword.CALAMITY,
	"capitalism": Keyword.CAPITALISM,
	"communism": Keyword.COMMUNISM,
	"copycat": Keyword.COPYCAT,
	"cougar": Keyword.COUGAR,
	"cougar-magnet": Keyword.COUGAR_MAGNET,
	"cultism": Keyword.CULTISM,
	"debating": Keyword.DEBATING,
	"democracy": Keyword.DEMOCRACY,
	"dinosaur": Keyword.DINOSAUR,
	"divine": Keyword.DIVINE,
	"elder-slime": Keyword.ELDER_SLIME,
	"equal-exchange": Keyword.EQUAL_EXCHANGE,
	"eruption": Keyword.ERUPTION,
	"everything": Keyword.EVERYTHING,
	"exam": Keyword.EXAM,
	"facism": Keyword.FACISM,
	"fam": Keyword.FAM,
	"farming": Keyword.FARMING,
	"father": Keyword.FATHER,
	"flush": Keyword.FLUSH,
	"greed": Keyword.GREED,
	"herwood": Keyword.HERWOOD,
	"humanity": Keyword.HUMANITY,
	"hustler": Keyword.HUSTLER,
	"ice-cream": Keyword.ICE_CREAM,
	"infinity": Keyword.INFINITY,
	"justice": Keyword.JUSTICE,
	"just-ok": Keyword.JUST_OK,
	"kamikaze": Keyword.KAMIKAZE,
	"little-sister": Keyword.LITTLE_SISTER,
	"loot": Keyword.LOOT,
	"lottery": Keyword.LOTTERY,
	"magic-potion": Keyword.MAGIC_POTION,
	"makkara": Keyword.MAKKARA,
	"makkarajarvi": Keyword.MAKKARAJARVI,
	"meemin": Keyword.MEEMIN,
	"mega-greed": Keyword.MEGA_GREED,
	"mic-pass": Keyword.MIC_PASS,
	"mikontalo": Keyword.MIKONTALO,
	"miner": Keyword.MINER,
	"monarchy": Keyword.MONARCHY,
	"much-higher": Keyword.MUCH_HIGHER,
	"natural-selection": Keyword.NATURAL_SELECTION,
	"necromancy": Keyword.NECROMANCY,
	"potential": Keyword.POTENTIAL,
	"poverty": Keyword.POVERTY,
	"propagation": Keyword.PROPAGATION,
	"replicate": Keyword.REPLICATE,
	"reverse-psychology": Keyword.REVERSE_PSYCHOLOGY,
	"rizz": Keyword.RIZZ,
	"rust": Keyword.RUST,
	"sahkotalo": Keyword.SAHKOTALO,
	"seeds": Keyword.SEEDS,
	"sinful": Keyword.SINFUL,
	"sister-virus": Keyword.SISTER_VIRUS,
	"slime": Keyword.SLIME,
	"spirit-dragon": Keyword.SPIRIT_DRAGON,
	"suck-this": Keyword.SUCK_THIS,
	"sus": Keyword.SUS,
	"swedish": Keyword.SWEDISH,
	"teleportation": Keyword.TELEPORTATION,
	"transfusion": Keyword.TRANSFUSION,
	"treasure": Keyword.TREASURE,
	"trump-card": Keyword.TRUMP_CARD,
	"tutor": Keyword.TUTOR,
	"wait-time": Keyword.WAIT_TIME,
	"wanderret": Keyword.WANDERRET,
	"watch-quick": Keyword.WATCH_QUICK,
	"wizard": Keyword.WIZARD,
	"zombie": Keyword.ZOMBIE
}

const KeywordDescriptions : Dictionary = {
	Keyword.AUTOCRACY: "Any card can devolve into this.",
	Keyword.BIG_CHUNGUS: "Gains the static effects of the cards supporting this card.",
	Keyword.CALAMITY: "You can play zombies from your grave. If a zombie would go into your grave, purge it instead.",
	Keyword.CAPITALISM: "Discard any number of cards, then draw that many cards.",
	Keyword.COMMUNISM: "Replace your bottom prize card with this card. While there, you can draw from opponent’s deck.",
	Keyword.COPYCAT: "You may copy target other card's [i]\"when played\"[/i] -effects.",
	Keyword.COUGAR: "...a card with 5 000 or less power, draw a card.",
	Keyword.COUGAR_MAGNET: "When a cougar supports this card, draw an additional card.",
	Keyword.CULTISM: "You can reshuffle all 7 little sisters, then draw a prize card.",
	Keyword.DEBATING: "If both players have the same number of cards on this column, and that number is 3 or higher, start a [i]debate[/i]. Reveal all cards on this column, and pair them in order. The player with more pairs won, wins this round. It tie, opponent wins.",
	Keyword.DEMOCRACY: "Gains the combined power of all cards supporting this card.",
	Keyword.DINOSAUR: "Dinosaur",
	Keyword.DIVINE: "Defeats any face-down card.",
	Keyword.ELDER_SLIME: "...from a non-elder slime, opponent discards 2 cards.",
	Keyword.EQUAL_EXCHANGE: "Opponent discards a card.",
	Keyword.ERUPTION: "Destroy all supporting cards.",
	Keyword.EVERYTHING: "If this card is destroyed,\nyou lose the round.",
	Keyword.EXAM: "Opponent guesses the type of the top card of your deck. Then, mill it.\n[b]•[/b] Right guess, they draw a card.\n[b]•[/b] Wrong guess, they discard a card.",
	Keyword.FACISM: "If they pass with %WEAK_TYPE with 5 000 or less power, destroy all %WEAK_TYPES.",
	Keyword.FAM: "...triggers twice more.",
	Keyword.FARMING: "Discard this and any number of other cards. For every 2 cards discarded, [i]grow[/i] [b][i](draw a card face-down to)[/i][/b] your [i]farm[/i]. During your turn, you may [i]reap[/i] the farm. [b]At the end of each round[/b], grow the farm.",
	Keyword.FATHER: "The father of",
	Keyword.FLUSH: "...%SAME_TYPE, you may purge %STRONG_TYPE from any grave.",
	Keyword.GREED: "Discard this card, your dice result is increased by 2.",
	Keyword.HERWOOD: "Look at the top 3 cards of your deck, and devolve this into 1 of them. If you do, add the other 2 into hand.",
	Keyword.HUMANITY: "If your hand is empty, draw a card. Then, you may devolve this into it.",
	Keyword.HUSTLER: "Reap opponent's farm.",
	Keyword.ICE_CREAM: "Mill 3. For each [i]vanilla[/i] [b][i](effectless)[/i][/b] card milled, draw a card. For each ice cream milled, repeat this process.",
	Keyword.INFINITY: "While fully supported, this card gains infinite power.",
	Keyword.JUSTICE: "If you discard a card, opponent [i]grows[/i] their farm with a card [b][i](face-down)[/i][/b] from their hand. During their turn, they may [i]reap[/i] the farm. [b]At the end of each round[/b], they grow [b][i](draw a card face-down to)[/i][/b] their farm. ",
	Keyword.JUST_OK: "Draw a card, discard a card.",
	Keyword.KAMIKAZE: "Destroy all cards supporting this. For each destroyed, opponent mills. If they deck out, draw a prize card.",
	Keyword.LITTLE_SISTER: "The little sister of",
	Keyword.LOOT: "Draw a card, discard a card.",
	Keyword.LOTTERY: "Roll a D6. If 1, destroy this card. If 6, search a %SAME_TYPE with %LESS_POWER or less power, and devolve this into it.",
	Keyword.MAGIC_POTION: "Roll a D6. If 1, destroy this card. If 6, draw a card.",
	Keyword.MAKKARA: "Makkara",
	Keyword.MAKKARAJARVI: "You may return a card supporting this to hand. If it was a makkara, you may discard it and draw a card.",
	Keyword.MEEMIN: "Meemin",
	Keyword.MEGA_GREED: "Discard hand, dice result increased by 1 for every 2 cards discarded.",
	Keyword.MIC_PASS: "You may reshuffle %SAME_TYPE.",
	Keyword.MIKONTALO: "You may return this card from field to hand. If you do, discard a card.",
	Keyword.MINER: "...on an empty stack, mill 2. Draw a card for each rock milled. For each miner milled, repeat this process.",
	Keyword.MONARCHY: "Cannot evolve. Defeats any %WEAK_TYPE with more power.",
	Keyword.MUCH_HIGHER: "When evolving / devolving, power difference must be 2 000 or more.",
	Keyword.NATURAL_SELECTION: "Discard this card. This round, each player can only play one more card. Those cards are played face-down.",
	Keyword.NECROMANCY: "You may play a zombie from your grave supporting this.",
	Keyword.POTENTIAL: "Roll a D6. If 1, destroy this card. If 6, search a gun with %MORE_POWER or more power, and evolve this into it.",
	Keyword.POVERTY: "To evolve this, discard a card.",
	Keyword.PROPAGATION: "When you reap your farm, you can use this card to start a new farm.",
	Keyword.REPLICATE: "Unlimited copies of this card.",
	Keyword.REVERSE_PSYCHOLOGY: "All cards can devolve, normal evolving is forbidden.",
	Keyword.RIZZ: "Opponent may discard a card to negate your rizz. If they don't, reveal one of their face-down cards.",
	Keyword.RUST: "Defeats any gun.",
	Keyword.SAHKOTALO: "You may discard up to 2 cards. If you do, retrigger the effects of up to that many cards supporting this.",
	Keyword.SEEDS: "...and any number of other %SAME_TYPES. For every 5 cards reshuffled, [i]grow[/i] [b][i](draw a card face-down to)[/i][/b] your [i]farm[/i]. During your turn, you may [i]reap[/i] the farm. [b]At the end of each round[/b], grow the farm.",
	Keyword.SINFUL: "...from a card with 2 000 or less power, mill 3. Opponent discards a card for each scissors milled.",
	Keyword.SISTER_VIRUS: "This card may evolve into any little sister in your grave.",
	Keyword.SLIME: "Slime",
	Keyword.SPIRIT_DRAGON: "The spirit dragon of",
	Keyword.SUCK_THIS: "If opponent has full field, you may discard this. If you do, destroy field.",
	Keyword.SUS: "...would be revealed, you may reveal this card from your hand instead.",
	Keyword.SWEDISH: "This card can evolve into a card with the same power.",
	Keyword.TELEPORTATION: "You may replace your primary card with this card from your hand. If you do, discard either %WEAK_TYPE or 2 cards.",
	Keyword.TRANSFUSION: "...on the primary stack, swap the places of 2 %SAME_TYPES.",
	Keyword.TREASURE: "Draw a card.",
	Keyword.TRUMP_CARD: "While you have 5 or less cards in hand, you may discard this card. If you do, negate all lingering effects. Also, hide all face-up prize cards.",
	Keyword.TUTOR: "Discard this. After drawing, search %SAME_TYPE with %LESS_POWER or less power.",
	Keyword.WAIT_TIME: "Negate until your next turn.",
	Keyword.WANDERRET: "...a wanderret, draw a card.",
	Keyword.WATCH_QUICK: "Reveal target face-down card.",
	Keyword.WIZARD: "Can evolve into any card, but play that card face-down.",
	Keyword.ZOMBIE: "Zombie"
}

const KeywordTags : Dictionary = {
	Keyword.AUTOCRACY: KeywordTag.STATIC,
	Keyword.BIG_CHUNGUS: KeywordTag.STATIC,
	Keyword.CALAMITY: KeywordTag.STATIC,
	Keyword.CAPITALISM: KeywordTag.WHEN_PLAYED,
	Keyword.COMMUNISM: KeywordTag.FROM_HAND,
	Keyword.COPYCAT: KeywordTag.WHEN_PLAYED,
	Keyword.COUGAR: KeywordTag.WHEN_SUPPORTING,
	Keyword.COUGAR_MAGNET: KeywordTag.STATIC,
	Keyword.CULTISM: KeywordTag.FROM_GRAVE,
	Keyword.DEBATING: KeywordTag.WHEN_PLAYED,
	Keyword.DEMOCRACY: KeywordTag.STATIC,
	Keyword.DINOSAUR: KeywordTag.TITLE,
	Keyword.DIVINE: KeywordTag.STATIC,
	Keyword.ELDER_SLIME: KeywordTag.WHEN_EVOLVES,
	Keyword.EQUAL_EXCHANGE: KeywordTag.IF_DISCARDED,
	Keyword.ERUPTION: KeywordTag.WHEN_PLAYED,
	Keyword.EVERYTHING: KeywordTag.STATIC,
	Keyword.EXAM: KeywordTag.WHEN_PLAYED,
	Keyword.FACISM: KeywordTag.OPPONENT_PASSES,
	Keyword.FAM: KeywordTag.IF_FULLY_SUPPORTED,
	Keyword.FARMING: KeywordTag.FROM_HAND,
	Keyword.FATHER: KeywordTag.TITLE,
	Keyword.FLUSH: KeywordTag.WHEN_SUPPORTING,
	Keyword.GREED: KeywordTag.START_OF_ROUND,
	Keyword.HERWOOD: KeywordTag.OPPONENT_PASSES,
	Keyword.HUMANITY: KeywordTag.WHEN_PLAYED,
	Keyword.HUSTLER: KeywordTag.WHEN_PLAYED,
	Keyword.ICE_CREAM: KeywordTag.WHEN_PLAYED,
	Keyword.INFINITY: KeywordTag.STATIC,
	Keyword.JUSTICE: KeywordTag.STATIC,
	Keyword.JUST_OK: KeywordTag.WHEN_RESHUFFLED,
	Keyword.KAMIKAZE: KeywordTag.WHEN_PLAYED,
	Keyword.LITTLE_SISTER: KeywordTag.TITLE,
	Keyword.LOOT: KeywordTag.WHEN_PLAYED,
	Keyword.LOTTERY: KeywordTag.WHEN_PLAYED,
	Keyword.MAGIC_POTION: KeywordTag.WHEN_PLAYED,
	Keyword.MAKKARA: KeywordTag.TITLE,
	Keyword.MAKKARAJARVI: KeywordTag.WHEN_PLAYED,
	Keyword.MEEMIN: KeywordTag.TITLE,
	Keyword.MEGA_GREED: KeywordTag.START_OF_ROUND,
	Keyword.MIC_PASS: KeywordTag.OPPONENT_PASSES,
	Keyword.MIKONTALO: KeywordTag.OPPONENT_PASSES,
	Keyword.MINER: KeywordTag.WHEN_PLAYED,
	Keyword.MONARCHY: KeywordTag.STATIC,
	Keyword.MUCH_HIGHER: KeywordTag.STATIC,
	Keyword.NATURAL_SELECTION: KeywordTag.START_OF_ROUND,
	Keyword.NECROMANCY: KeywordTag.WHEN_PLAYED,
	Keyword.POTENTIAL: KeywordTag.WHEN_PLAYED,
	Keyword.POVERTY: KeywordTag.STATIC,
	Keyword.PROPAGATION: KeywordTag.FROM_GRAVE,
	Keyword.REPLICATE: KeywordTag.DECK_BUILDING,
	Keyword.REVERSE_PSYCHOLOGY: KeywordTag.STATIC,
	Keyword.RIZZ: KeywordTag.DISCARD_FROM_HAND,
	Keyword.RUST: KeywordTag.STATIC,
	Keyword.SAHKOTALO: KeywordTag.WHEN_PLAYED,
	Keyword.SEEDS: KeywordTag.RESHUFFLE_THIS,
	Keyword.SINFUL: KeywordTag.WHEN_EVOLVES,
	Keyword.SISTER_VIRUS: KeywordTag.STATIC,
	Keyword.SLIME: KeywordTag.TITLE,
	Keyword.SPIRIT_DRAGON: KeywordTag.TITLE,
	Keyword.SUCK_THIS: KeywordTag.FROM_HAND,
	Keyword.SUS: KeywordTag.IF_A_FACE_DOWN_CARD,
	Keyword.SWEDISH: KeywordTag.STATIC,
	Keyword.TELEPORTATION: KeywordTag.OPPONENT_PASSES,
	Keyword.TRANSFUSION: KeywordTag.WHEN_PLAYED,
	Keyword.TREASURE: KeywordTag.WHEN_MILLED,
	Keyword.TRUMP_CARD: KeywordTag.FROM_HAND,
	Keyword.TUTOR: KeywordTag.START_OF_ROUND,
	Keyword.WAIT_TIME: KeywordTag.WHEN_PLAYED,
	Keyword.WANDERRET: KeywordTag.WHEN_SUPPORTING,
	Keyword.WATCH_QUICK: KeywordTag.RESHUFFLE_THIS,
	Keyword.WIZARD: KeywordTag.STATIC,
	Keyword.ZOMBIE: KeywordTag.TITLE
}

func is_title_keyword(keyword : Keyword) -> bool:
	return KeywordTags[keyword] == KeywordTag.TITLE;

func is_keyword_grave_effect(keyword : Keyword) -> bool:
	return GRAVE_EFFECT_TAGS.has(KeywordTags[keyword]) \
		or GRAVE_KEYWORDS.has(keyword);

func is_long_keyword(keyword : Keyword) -> bool:
	return KeywordDescriptions[keyword].length() > 80;

func get_keyword_text(keyword : Keyword, card_type : CardType = CardType.ROCK, hide_reminder : bool = false, is_only_keyword : bool = false, power : int = 0, bolden_tag : bool = false, is_second_title_in_row : bool = false) -> String:
	var keyword_name : String = KeywordNames[keyword];
	var tag_name : String = KeywordTagNames[KeywordTags[keyword]];
	var description : String = enrich_keyword_description(KeywordDescriptions[keyword], card_type, power);
	var over_length_limit : bool = keyword_name.length() + tag_name.length() > 25;
	var title_font_size : int = 40 if over_length_limit else 48;
	var name_font_size : int = (52 if over_length_limit else 56) if bolden_tag else 48;
	var font_size : int = 40 if description.length() > 64 else 48;
	var tag_font : String = TAG_FONT_ITALIC_BOLDEN if bolden_tag else TAG_FONT_ITALIC_TEXT_BOLDEN;
	var formatted_name : String = "[font_size=%s][b]%s[/b][/font_size]" % [name_font_size, keyword_name];
	if "-" in keyword_name:
		var dash_idx = keyword_name.find("-");
		formatted_name = KEYWORD_DASHED_NAME_STRING % [name_font_size, keyword_name.substr(0, dash_idx + 1), keyword_name.substr(dash_idx + 1)];
	if is_title_keyword(keyword):
		font_size = 48 if (is_only_keyword or is_second_title_in_row) else 40;
		if is_only_keyword:
			description = description.trim_suffix(" of");
		return TITLE_STRING % [font_size, description];
	if hide_reminder:
		return KEYWORD_REMINDLESS_STRING % [
			formatted_name,
			tag_font,
			title_font_size,
			tag_name,
		];
	return KEYWORD_STRING % [
		formatted_name,
		tag_font,
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

func format_power(power : int) -> String:
	var power_string : String = str(power);
	var formatted : String = "";
	var digits_added : int = 0;
	for i in range(power_string.length() - 1, -1, -1):
		formatted = power_string[i] + formatted;
		digits_added += 1;
		if digits_added % 3 == 0 and i != 0:
			formatted = " " + formatted;
	return formatted;

func enrich_keyword_description(description : String, card_type : CardType = CardType.ROCK, power : int = 0) -> String:
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
		.replace("%STRONG_TYPE", strong_type) \
		.replace("%THIS_POWER", format_power(power)) \
		.replace("%MORE_POWER", format_power(min(power + 1000, 13000))) \
		.replace("%LESS_POWER", format_power(max(power - 1000, 0)));
