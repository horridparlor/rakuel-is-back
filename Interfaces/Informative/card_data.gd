extends Node
class_name CardData

const JSON_DATA_PATH : String = "Cards/";
const DEFAULT_DATA : Dictionary = {
	"id": 0,
	"name": "Name Missing",
	"type": "Rock",
	"power": 0,
	"keywords": [],
	"hide_reminder_text": [],
	"created_at": "2026-12-31"
}

var card_id : int;
var card_name : String;
var card_type : CardEnums.CardType;
var card_type_name : String;
var power : int;
var keywords : Array;
var hide_reminder_text : Dictionary;
var has_title : bool;
var has_grave_effect : bool;
var created_at : String;
var release_year : int;

func _init(id_ : int) -> void:
	card_id = id_;
	load_json();

func load_json() -> void:
	var data : Dictionary = System.Json.read_data(JSON_DATA_PATH + str(card_id));
	data = System.Dictionaries.make_safe(data, DEFAULT_DATA);
	card_name = data.name;
	card_type = CardEnums.translate_type(data.type);
	card_type_name = CardEnums.TranslateCardType[card_type].to_lower();
	power = data.power;
	eat_keywords(data.keywords);
	eat_hide_reminder_text(data.hide_reminder_text);
	created_at = data.created_at;
	release_year = int(created_at.substr(0, 4));

func eat_keywords(source : Array) -> void:
	for keyword_string in source:
		if CardEnums.TranslateKeyword.has(keyword_string):
			keywords.append(CardEnums.TranslateKeyword[keyword_string]);
	for keyword in keywords:
		if CardEnums.is_title_keyword(keyword):
			if keyword == CardEnums.Keyword.ZOMBIE:
				has_grave_effect = true;
			has_title = true;
		if CardEnums.is_keyword_grave_effect(keyword):
			has_grave_effect = true;

func eat_hide_reminder_text(source : Array) -> void:
	for keyword_string in source:
		if CardEnums.TranslateKeyword.has(keyword_string):
			hide_reminder_text[CardEnums.TranslateKeyword[keyword_string]] = null;

func get_effects_text() -> String:
	var effects_text : String;
	for keyword in keywords:
		if !effects_text.is_empty():
			effects_text += "\n";
		effects_text += CardEnums.get_keyword_text(keyword, card_type, hide_reminder_text.has(keyword), keywords.size() == 1);
	return effects_text;
