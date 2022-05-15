/// @func CollageDrawImageExt(image, image_index, x, y, xscale, yscale, rot, col, alpha);
/// @param image
/// @param image_index
/// @param x
/// @param y
/// @param xscale
/// @param yscale
/// @param rot
/// @param col
/// @param alpha
function CollageDrawImageExt(_imageData, _imageIndex, _x, _y, _xScale, _yScale, _rot, _col, _alpha) {
	gml_pragma("forceinline");
	var _ratio = _imageData.ratio;
	var _uvs = _imageData.subImagesArray[_imageIndex % _imageData.subImagesCount];
	if (buffer_exists(_uvs.texturePageStruct.cacheBuffer)) {
		_uvs.texturePageStruct.__restoreFromCache();	
	} 
	if (COLLAGE_AUTO_CHECK_TEXTURE_PAGES) _uvs.texturePageStruct.checkSurface();	
	
	draw_surface_general(_uvs.texturePageStruct.surface, _uvs.left, _uvs.top, _uvs.right, _uvs.bottom, _x+_uvs.xPos, _y+_uvs.yPos, _xScale/_ratio, _yScale/_ratio, _rot, _col, _col, _col, _col, _alpha);	
}
