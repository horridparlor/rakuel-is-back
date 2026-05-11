extends Node

const Dictionaries : GDScript = preload("res://Scripts/System/dictionaries.gd")
const Instance : GDScript = preload("res://Scripts/System/instance.gd");
const Json : GDScript = preload("res://Scripts/System/json.gd");
const Paths : GDScript = preload("res://Scripts/paths.gd");
const Random : GDScript = preload("res://Scripts/System/random.gd");

var random : RandomNumberGenerator = RandomNumberGenerator.new();

func init() -> void:
	random.randomize();
