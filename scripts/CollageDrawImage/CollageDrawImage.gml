/// @func CollageDrawImage(image, image_index, x, y);
/// @param image
/// @param image_index
/// @param x
/// @param y
function CollageDrawImage(_imageData, _imageIndex, _x, _y) {
	gml_pragma("forceinline");
	var _image = __CollageImageFetchPointer(_imageData);
	var _ratio = _image.ratio;
	var _uvs = _image.subImagesArray[_imageIndex % _image.subImagesCount];
	if (buffer_exists(_uvs.texturePageStruct.cacheBuffer)) {
		_uvs.texturePageStruct.__restoreFromCache();	
	} 
	
	if (COLLAGE_AUTO_CHECK_TEXTURE_PAGES) _uvs.texturePageStruct.checkSurface();	
	
	
	if (_ratio != 1) {
		draw_surface_part_ext(_uvs.texturePageStruct.surface, _uvs.left, _uvs.top, _uvs.right, _uvs.bottom, _x+_uvs.xPos, _y+_uvs.yPos, 1/_ratio, 1/_ratio, c_white, 1);	
	} else {
		draw_surface_part(_uvs.texturePageStruct.surface, _uvs.left, _uvs.top, _uvs.right, _uvs.bottom, _x+_uvs.xPos, _y+_uvs.yPos);	
	}
}
