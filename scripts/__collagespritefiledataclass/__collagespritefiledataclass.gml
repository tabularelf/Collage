/// @ignore
// Feather ignore all
function __CollageSpriteFileDataClass(_identifier, _spriteID, _subImage = 1, _isCopy = (_spriteID > global.__CollageGMSpriteCount)) constructor {
	__name = _identifier;
	__subImages = _subImage;
	__xOrigin = 0;
	__yOrigin = 0;
	if (!sprite_exists(_spriteID)) {
		__CollageThrow("Invalid spriteID: " + string(__spriteID));	
	}
	__spriteID = _spriteID;
	__is3D = 0;
	__isCopy = _isCopy;
	__keepTogether = false;
	
	static KeepTogether = function(_bool) {
		__keepTogether = _bool;
		return self;
	}
	
	static SetOrigin = function(_xOrigin, _yOrigin) {
		var _origin = __CollageOriginValidator(__spriteID, _xOrigin, _yOrigin);
		__xOrigin = _origin[0];
		__yOrigin = _origin[1];
		return self;
	}
	
	static Set3D = function(_3d) {
		__is3D = _3d;
		return self;
	}
}
