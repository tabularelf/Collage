/// @func CollageDrawImageGeneral(sprite_index/image, image_index, left, top, width, height, x, y, xscale, yscale, rot, col1, col2, col3, col4, alpha);
/// @param sprite_index/image
/// @param image_index
/// @param left
/// @param top
/// @param width
/// @param height
/// @param x
/// @param y
/// @param xscale
/// @param yscale
/// @param rot
/// @param col1
/// @param col2
/// @param col3
/// @param col4
/// @param alpha
function CollageDrawImageGeneral(_imageData, _imageIndex, _left, _top, _width, _height, _x, _y, _xScale, _yScale, _rot, _col1, _col2, _col3, _col4, _alpha) {
	gml_pragma("forceinline");
	var _ratio = _imageData.ratio;
	var _uvs = _imageData.subImagesArray[_imageIndex % _imageData.subImagesCount];
	if (buffer_exists(_uvs.texturePageStruct.cacheBuffer)) {
		_uvs.texturePageStruct.__restoreFromCache();	
	} 
	if (COLLAGE_AUTO_CHECK_TEXTURE_PAGES) _uvs.texturePageStruct.checkSurface();	
	
	draw_surface_general(_uvs.texturePageStruct.surface, clamp(_uvs.left+_left, _uvs.left, _uvs.left+_uvs.right), clamp(_uvs.top+_top, _uvs.top, _uvs.top+_uvs.bottom), clamp(_width, _left, _uvs.right), clamp(_height, _top, _uvs.bottom), _x+_uvs.xPos, _y+_uvs.yPos, _xScale/_ratio, _yScale/_ratio, _rot, _col1, _col2, _col3, _col4, _alpha);	
}
