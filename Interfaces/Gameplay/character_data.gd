extends Node
class_name CharacterData

const JSON_DATA_PATH : String = "Characters/";
const DEFAULT_DATA : Dictionary = {
	"name": "Name Missing",
	"entity": "name_missing"
}
const ENTITY_PATH_STRING = "res://Prefabs/Characters/%s.tscn";

var id : int;
var character_name : String;
var entity_path : String;
var player : Player;

func _init(id_ : int) -> void:
	id = id_;
	load_json();

func load_json() -> void:
	var data : Dictionary = System.Json.read_data(JSON_DATA_PATH + str(id));
	data = System.Dictionaries.make_safe(data, DEFAULT_DATA);
	character_name = data.name;
	entity_path = ENTITY_PATH_STRING % [data.entity];
