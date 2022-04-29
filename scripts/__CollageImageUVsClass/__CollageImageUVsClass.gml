function __CollageImageUVsClass(_texPageStruct, _texPageNum, _left, _top, _right, _bottom, _trimLeft = 0, _trimTop = 0, _ogW = 0, _ogH = 0, _xOffset = 0, _yOffset = 0) constructor {
	left = _left;
	right = _right;
	top = _top;
	bottom = _bottom;
	trimLeft = _trimLeft;
	trimTop = _trimTop;
	//trimRight = _trimRight;
	//trimBottom = _trimBottom;
	normLeft = _left / _texPageStruct.width;
	normRight = (_right / _texPageStruct.width);
	normTop = _top / _texPageStruct.height;
	normBottom = (_bottom / _texPageStruct.height);
	originalWidth = _ogW;
	originalHeight = _ogH;
	xPos = _trimLeft-_xOffset;
	yPos = _trimTop-_yOffset;
	texturePageNum = _texPageNum;
	texturePageStruct = _texPageStruct;
}
