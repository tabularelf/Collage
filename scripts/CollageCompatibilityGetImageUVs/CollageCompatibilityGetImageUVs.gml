function CollageCompatibilityGetImageUVs() {
	gml_pragma("forceinline");
    var _uvs;
    if (is_string(_spriteName)) {
		_uvs = global.__CollageImageMap[$ _spriteName].getUVs(_imageIndex);
	} else {
	    _uvs =_spriteName.getUVs(_imageIndex);
	}
	var _texPage = _uvs.texturePageStruct;
	var _width = _texPage.width;
	var _height = _texPage.height;
	
	return [_uvs.normLeft, _uvs.normTop, _uvs.normRight, _uvs.normBottom, _uvs.trimLeft, _uvs.trimTop, _uvs.originalWidth/_width, _uvs.originalHeight/_height];
}