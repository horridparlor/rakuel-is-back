enum Direction {
	UP,
	RIGHT,
	DOWN,
	LEFT
}

static func set_all_borders(style : StyleBoxFlat, border_width : int) -> void:
	style.border_width_bottom = border_width;
	style.border_width_left = border_width;
	style.border_width_right = border_width;
	style.border_width_top = border_width;

static func set_all_corners(style : StyleBoxFlat, corner_radius : int) -> void:
	style.corner_radius_bottom_left = corner_radius;
	style.corner_radius_bottom_right = corner_radius;
	style.corner_radius_top_left = corner_radius;
	style.corner_radius_top_right = corner_radius;

static func set_colours(style : StyleBoxFlat, bg_color : String, border_color : String = "ffffff") -> void:
	style.bg_color = bg_color;
	style.border_color = border_color;

static func set_borders_in_direction(style : StyleBoxFlat, border_width : int, direction : Direction) -> void:
	match direction:
		Direction.UP:
			style.border_width_bottom = border_width;
		Direction.RIGHT:
			style.border_width_right = border_width;
		Direction.DOWN:
			style.border_width_bottom = border_width;
		Direction.LEFT:
			style.border_width_left = border_width;

static func set_corners_in_direction(style : StyleBoxFlat, corner_radius : int, direction : Direction) -> void:
	match direction:
		Direction.UP:
			style.corner_radius_top_left = corner_radius;
			style.corner_radius_top_right = corner_radius;
		Direction.RIGHT:
			style.corner_radius_bottom_right = corner_radius;
			style.corner_radius_top_right = corner_radius;
		Direction.DOWN:
			style.corner_radius_bottom_left = corner_radius;
			style.corner_radius_bottom_right = corner_radius;
		Direction.LEFT:
			style.corner_radius_bottom_left = corner_radius;
			style.corner_radius_top_left = corner_radius;
