/// @ignore
/// feather ignore all
function __CollageImageClass(_spriteStruct, _name, _cropW, _cropH, _tiling, _ratio, _xOffset, _yOffset) constructor {
	__width = _spriteStruct.spriteInfo.width;
	__height  = _spriteStruct.spriteInfo.height;
	__cropWidth = _cropW;
	__cropHeight = _cropH;
	__xoffset = _xOffset;
	__yoffset = _yOffset;
	__name = _name;
	__subImagesCount = _spriteStruct.spriteInfo.num_subimages;
	__subImagesArray = array_create(__subImagesCount);
	__ratio = _ratio;
    __scaled = 1/_ratio;
	__tiling = _tiling;
	
	static __InternalGetUvs = function(_imageIndex) {
		return __subImagesArray[_imageIndex % __subImagesCount];
	}
	
	static GetName = function() {
		return __name;	
	}
	
	static GetWidth = function() {
		return __width;	
	}
	
	static GetHeight = function() {
		return __height;	
	}
	
	static GetXOffset = function() {
		return __xoffset;	
	}
	
	static GetYOffset = function() {
		return __yoffset;	
	}
	
	static GetUVs = function(_imageIndex) {
		return __InternalGetUvs(_imageIndex);	
	}
	
	static GetSurface = function(_imageIndex) {
		var _texPage = __subImagesArray[_imageIndex % __subImagesCount].texturePageStruct;
		return _texPage.GetSurface();	
	}
	
	static GetTexture = function(_imageIndex) {
		var _texPage = __subImagesArray[_imageIndex % __subImagesCount].texturePageStruct;
		return _texPage.GetTexture();	
	}
	
	static GetTexturePage = function(_imageIndex) {
		return __subImagesArray[_imageIndex % __subImagesCount].texturePageStruct;
	}
	
	static GetCount = function() {
		return __subImagesCount;	
	}
	
	static ToSprite = function() {
		var _uvs = GetUVs(0);
		var _sprite = sprite_create_from_surface(_uvs.texturePageStruct.GetSurface(), _uvs.left, _uvs.top, _uvs.right, _uvs.bottom, false, false, 0, 0);
		
		var _i = 1;
		repeat(GetCount()-1) {
			_uvs = _data.image.GetUVs(_i);
			sprite_add_from_surface(_sprite, _uvs.texturePageStruct.GetSurface(), _uvs.left, _uvs.top, _uvs.right, _uvs.bottom, false, false);	
			++_i;
		}	
		return _sprite;
	}
}
