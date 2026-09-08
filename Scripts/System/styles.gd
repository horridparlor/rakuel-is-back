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

# One segment count per edge (top, right, bottom, left), so a serrated rect and
# a smaller/larger inset copy of it can share the same tooth positions.
static func compute_serrated_segment_counts(rect_size : Vector2, horizontal_tooth_length : float, vertical_tooth_length : float) -> Array:
	var horizontal_segments : int = max(2, roundi(rect_size.x / horizontal_tooth_length));
	# Each edge starts flat at its corner, so both corners only end up looking
	# the same (both leaning "out") when the segment count is even - an odd
	# count leaves one end notched "in" instead, making the two corners of the
	# same edge look unequal.
	if horizontal_segments % 2 != 0:
		horizontal_segments -= 1;
	var vertical_segments : int = max(2, roundi(rect_size.y / vertical_tooth_length));
	# Every edge starts flat at its corner but ends on a tooth, so which way that
	# last tooth leans (in/out) depends on whether its segment count is odd or
	# even. Match parities so all four corners lean the same way.
	if (vertical_segments % 2) != (horizontal_segments % 2):
		vertical_segments += 1;
	return [horizontal_segments, vertical_segments, horizontal_segments, vertical_segments];

static func generate_serrated_rect_points(rect : Rect2, segment_counts : Array, tooth_depth_out : float, tooth_depth_in : float) -> PackedVector2Array:
	var points : PackedVector2Array = PackedVector2Array();
	var corners : Array = [
		rect.position,
		Vector2(rect.end.x, rect.position.y),
		rect.end,
		Vector2(rect.position.x, rect.end.y),
	];
	var normals : Array = [
		Vector2(0, 1),
		Vector2(-1, 0),
		Vector2(0, -1),
		Vector2(1, 0),
	];
	for edge_idx in range(4):
		var start : Vector2 = corners[edge_idx];
		var end : Vector2 = corners[(edge_idx + 1) % 4];
		var normal : Vector2 = normals[edge_idx];
		var segment_count : int = segment_counts[edge_idx];
		var step : Vector2 = (end - start) / segment_count;
		for i in range(segment_count):
			var offset : float = 0.0 if i == 0 else (tooth_depth_out if i % 2 == 1 else -tooth_depth_in);
			points.append(start + step * i + normal * offset);
	return points;

# Shrinks a (possibly jagged) closed polygon inward by a uniform perpendicular
# distance, mitering each vertex along the bisector of its two edge normals -
# a plain "same tooth depth on a smaller rect" copy does NOT give an even
# border on diagonal tooth edges, this does.
static func inset_polygon_points(points : PackedVector2Array, inset : float) -> PackedVector2Array:
	var count : int = points.size();
	var result : PackedVector2Array = PackedVector2Array();
	result.resize(count);
	for i in range(count):
		var prev : Vector2 = points[(i - 1 + count) % count];
		var curr : Vector2 = points[i];
		var next : Vector2 = points[(i + 1) % count];
		var normal_in : Vector2 = Vector2(-(curr - prev).normalized().y, (curr - prev).normalized().x);
		var normal_out : Vector2 = Vector2(-(next - curr).normalized().y, (next - curr).normalized().x);
		var bisector : Vector2 = normal_in + normal_out;
		if bisector.length_squared() < 0.0001:
			result[i] = curr + normal_in * inset;
		else:
			bisector = bisector.normalized();
			var miter_scale : float = inset / clampf(bisector.dot(normal_in), 0.35, 1.0);
			result[i] = curr + bisector * min(miter_scale, inset * 3.0);
	return result;
