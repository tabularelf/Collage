function __CollageImageFetchPointer(_identifier) {
	if (is_struct(_identifier)) {
		return _identifier;	
	} else {
		var _sprite =  global.__CollageImageMap[$ _identifier];
		if (_sprite != undefined) {
			return _sprite;
		} else {
			__CollageThrow("There is no image called " + string(_identifier));
		}
	}
}
