function __CollageImageFetchPointer(_identifier) {
	if (is_struct(_identifier) && (instanceof(_identifier) == "__CollageImageInfo")) {
		return _identifier;	
	} else {
		var _sprite =  global.__CollageImageMap[$ _identifier];
		if (_sprite != undefined) {
			return _sprite;
		} else {
			__CollageThrow("There is no image called " + string(_identifier));
		}
	}
	
	__CollageThrow(string(_identifier) + " is not a Collage image!");	
}
