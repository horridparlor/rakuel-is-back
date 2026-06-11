static func remove_bbcode_tags(message : String) -> String:
	var regex : RegEx = RegEx.new();
	regex.compile("\\[/?[^\\]]+\\]");
	return regex.sub(message, "", true);
