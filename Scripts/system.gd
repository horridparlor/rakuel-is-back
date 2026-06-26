extends Node

const Dictionaries : GDScript = preload("res://Scripts/System/dictionaries.gd")
const Instance : GDScript = preload("res://Scripts/System/instance.gd");
const Json : GDScript = preload("res://Scripts/System/json.gd");
const Paths : GDScript = preload("res://Scripts/System/paths.gd");
const Random : GDScript = preload("res://Scripts/System/random.gd");
const Strings : GDScript = preload("res://Scripts/System/strings.gd");
const Styles : GDScript = preload("res://Scripts/System/styles.gd");

var random : RandomNumberGenerator = RandomNumberGenerator.new();
var game_speed : float = 1.0;

func init() -> void:
	random.randomize();
	Json.create_directories();

func wait(wait : float) -> void:
	var timer : Timer = Timer.new();
	timer.wait_time = wait;
	timer.one_shot = true;
	add_child(timer);
	timer.start();
	await timer.timeout;
	timer.queue_free();
