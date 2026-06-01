const SAVE_WRITE_PATH_PREFIX : String = "user://json-data/";
const DATA_WRITE_PATH_PREFIX : String = "res://Data/";
const ERROR_KEY : String = "SYSTEM_RESERVER_KEY_ERROR";
const ERROR : Dictionary = {
	ERROR_KEY: ERROR_KEY
}
const SCREENSHOTS_PATH : String = "user://screenshots/";

static func success(json_data : Dictionary) -> bool:
	return not is_error(json_data);

static func is_error(json_data : Dictionary) -> bool:
	return json_data.has(ERROR_KEY);

static func create_directories() -> void:
	var dir: DirAccess;
	for path in [
		SAVE_WRITE_PATH_PREFIX,
		SCREENSHOTS_PATH,
	]:
		dir = DirAccess.open(path);
		if dir == null:
			DirAccess.make_dir_recursive_absolute(path);

static func get_file_path(file_prefix : String, file_name : String) -> String:
	return file_prefix + file_name + ".json";

static func get_save_file_path(file_name : String) -> String:
	return get_file_path(SAVE_WRITE_PATH_PREFIX, file_name);

static func get_data_file_path(file_name : String) -> String:
	return get_file_path(DATA_WRITE_PATH_PREFIX, file_name);

static func write(json_data: Dictionary, file_name: String) -> void:
	var file: FileAccess = FileAccess.open(file_name, FileAccess.WRITE);
	if not file:
		return;
	file.store_string(JSON.stringify(json_data));
	file.close();

static func read(file_name: String, do_debug : bool = false) -> Dictionary:
	var json_data : Dictionary;
	var file: FileAccess = FileAccess.open(file_name, FileAccess.READ);
	if do_debug:
		print("Reading: %s \n%s" % [file_name, not not file]);
	if not file:
		return ERROR;
	json_data = parse(file.get_as_text());
	file.close();
	return json_data;

static func read_text_array(file_name: String, do_debug: bool = false) -> Dictionary:
	var result: Dictionary = {"lines": []};
	var file := FileAccess.open(file_name, FileAccess.READ);
	if do_debug:
		print("Reading lines: %s \nOpened: %s" % [file_name, file != null]);
	if file == null:
		push_error("Failed to open file: %s" % file_name);
		return ERROR;
	while file.get_position() < file.get_length():
		var line: String = file.get_line().strip_edges();
		result["lines"].append(line);
	file.close();
	return result;

static func parse(json_string : String) -> Dictionary:
	var json : JSON = JSON.new();
	var json_data = json.parse_string(json_string);
	if not json_data:
		return ERROR;
	return json_data;

static func read_save(file_name: String) -> Dictionary:
	return read(get_save_file_path(file_name));

static func write_save(json_data: Dictionary, file_name: String) -> void:
	write(json_data, get_save_file_path(file_name));

static func read_data(file_name: String, do_debug: bool = false) -> Dictionary:
	return read(get_data_file_path(file_name), do_debug);

static func write_data(json_data: Dictionary, file_name: String) -> void:
	write(json_data, get_data_file_path(file_name));

static func take_screenshot(node : Node2D, custom_name : String = "", area : Vector2 = Vector2.ZERO, corner_radius : int = 0) -> void:
	var viewport := node.get_viewport();
	var image : Image = viewport.get_texture().get_image();
	image.convert(Image.FORMAT_RGBA8);

	if area != Vector2.ZERO:
		var canvas_transform := viewport.get_canvas_transform();
		var scale : Vector2 = canvas_transform.get_scale();
		var full_size : Vector2i = image.get_size();

		var crop_w : int = int(area.x * scale.x);
		var crop_h : int = int(area.y * scale.y);

		var node_screen_pos : Vector2 = canvas_transform * node.global_position;
		var crop_x : int = clamp(int(node_screen_pos.x - crop_w / 2.0), 0, full_size.x - crop_w);
		var crop_y : int = clamp(int(node_screen_pos.y - crop_h / 2.0), 0, full_size.y - crop_h);

		var cropped : Image = Image.create(crop_w, crop_h, false, Image.FORMAT_RGBA8);
		cropped.blit_rect(image, Rect2i(crop_x, crop_y, crop_w, crop_h), Vector2i.ZERO);
		image = cropped;
		image.resize(int(area.x), int(area.y), Image.INTERPOLATE_LANCZOS);

	if corner_radius > 0:
		var w : int = image.get_width();
		var h : int = image.get_height();
		var r : int = corner_radius;

		for y : int in range(h):
			for x : int in range(w):
				var dx : int = min(x, w - 1 - x);
				var dy : int = min(y, h - 1 - y);

				if dx < r and dy < r:
					if (dx - r) * (dx - r) + (dy - r) * (dy - r) > r * r:
						var color : Color = image.get_pixel(x, y);
						color.a = 0.0;
						image.set_pixel(x, y, color);

	var file_name : String = custom_name if custom_name != "" else Time.get_datetime_string_from_system();
	file_name = file_name.replace(":", "-");

	var file_path : String = "user://screenshots/%s.png" % file_name;
	var error : int = image.save_png(file_path);

	if error == OK:
		print("Screenshot saved to: ", file_path);
	else:
		print("Error saving screenshot to: ", file_path);
