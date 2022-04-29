function __CollageImageFetchPointer(_identifier) {
	if (is_struct(_identifier) && (instanceof(_identifier) == "__CollageImageInfo")) {
		return _identifier;	
	} else if (is_string(_identifier)) {
		if (!COLLAGE_IMAGES_ARE_PUBLIC) {
			__CollageThrow("COLLAGE_IMAGES_ARE_PUBLIC is set to false and therefore string names do not work.");
		}
		var _image =  global.__CollageImageMap[$ _identifier];
		if (_image != undefined) {
			return _image;
		} else {
			__CollageThrow("There is no image called " + string(_identifier));
		}
	}
	
	__CollageThrow(string(_identifier) + " is not a Collage image!");	
}
