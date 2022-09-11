/// @ignore
// Feather ignore all
function __CollageSpriteFileDataClass(_identifier, _spriteID, _subImage = 1, _xOrigin = 0, _yOrigin = 0, _is3D = false) constructor {
	name = _identifier;
	subImages = _subImage;
	xOrigin = _xOrigin;
	yOrigin = _yOrigin;
	spriteID = _spriteID;
	is3D = _is3D;
	isCopy = (_spriteID > global.__CollageGMSpriteCount);
}
