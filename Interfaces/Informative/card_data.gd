extends Node
class_name CardData

const JSON_DATA_PATH : String = "Cards/";
const DEFAULT_DATA : Dictionary = {
	"id": 0,
	"name": "Name Missing",
	"type": "Rock",
	"power": 0,
	"keywords": [],
	"created_at": "2026-12-31"
}

var card_id : int;
var card_name : String;
var card_type : CardEnums.CardType;
var power : int;
var keywords : Array;
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
	power = data.power;
	created_at = data.created_at;
	release_year = int(created_at.substr(0, 4));
