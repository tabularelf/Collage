function __CollageImageInfo(_spriteInfo, _name, _cropW, _cropH, _ratio) constructor {
	width = _spriteInfo.width;
	height  = _spriteInfo.height;
	cropWidth = _cropW;
	cropHeight = _cropH;
	//show_message([cropWidth, cropHeight, [_spriteInfo.bbox_left, _spriteInfo.bbox_top, _spriteInfo.bbox_right, _spriteInfo.bbox_bottom]]);
	xoffset = _spriteInfo.xoffset;
	yoffset = _spriteInfo.yoffset;
	name = _name;
	subImagesCount = _spriteInfo.num_subimages;
	subImagesArray = array_create(subImagesCount);
	ratio = _ratio;
	
	static getTexture = function(_imageIndex) {
		var _texPage = subImagesArray[_imageIndex % subImagesCount].texturePageStruct;
		_texPage.checkSurface();
		return surface_get_texture(_texPage.surface);
	}
	
	static getUVs = function(_imageIndex) {
		return subImagesArray[_imageIndex % subImagesCount];
	}
}
