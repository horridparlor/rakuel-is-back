extends Node

const Instance : GDScript = preload("res://Scripts/System/instance.gd");
const Paths : GDScript = preload("res://Scripts/paths.gd");
const Random : GDScript = preload("res://Scripts/System/random.gd");

var random : RandomNumberGenerator = RandomNumberGenerator.new();

func init() -> void:
	random.randomize();
