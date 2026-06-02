extends Node
class_name CardData

const JSON_DATA_PATH : String = "Cards/";
const DEFAULT_DATA : Dictionary = {
	"id": 0,
	"name": "Name Missing",
	"power": 0
}

var card_id : int;
var card_name : String;
var power : int;

func _init(id_ : int) -> void:
	card_id = id_;
	load_json();

func load_json() -> void:
	var data : Dictionary = System.Json.read_data(JSON_DATA_PATH + str(card_id));
	data = System.Dictionaries.make_safe(data, DEFAULT_DATA);
	card_name = data.name;
	power = data.power;
