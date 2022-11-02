/// @ignore
function __CollageImageClass(_spriteInfo, _name, _cropW, _cropH, _ratio, _xOffset, _yOffset) constructor {
	width = _spriteInfo.width;
	height  = _spriteInfo.height;
	cropWidth = _cropW;
	cropHeight = _cropH;
	xoffset = _xOffset;
	yoffset = _yOffset;
	name = _name;
	subImagesCount = _spriteInfo.num_subimages;
	subImagesArray = array_create(subImagesCount);
	ratio = _ratio;
	
	static GetTexture = function(_imageIndex) {
		var _texPage = subImagesArray[_imageIndex % subImagesCount].texturePageStruct;
		_texPage.checkSurface();
		return surface_get_texture(_texPage.surface);
	}
	
	static __InternalGetUvs = function(_imageIndex) {
		return subImagesArray[_imageIndex % subImagesCount];
	}
	
	static GetUVs = function(_imageIndex) {
		return __CollageCloneStruct(__InternalGetUvs(_imageIndex));	
	}
	
	static GetSurface = function(_imageIndex) {
		var _texPage = subImagesArray[_imageIndex % subImagesCount].texturePageStruct;
		_texPage.checkSurface();
		return _texPage.surface;	
	}
	
	static GetTexture = function(_imageIndex) {
		var _texPage = subImagesArray[_imageIndex % subImagesCount].texturePageStruct;
		return _texPage.GetTexture();	
	}
	
	static GetTexturePage = function(_imageIndex) {
		return subImagesArray[_imageIndex % subImagesCount].texturePageStruct;
	}
}
