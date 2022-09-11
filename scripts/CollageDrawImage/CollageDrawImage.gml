/// @func CollageDrawImage(image, image_index, x, y);
/// @param {Struct} image
/// @param {Real} image_index
/// @param {Real} x
/// @param {Real} y
/* Feather ignore once GM1042 */
function CollageDrawImage(_imageData, _imageIndex, _x, _y) {
	gml_pragma("forceinline");
	var _ratio = _imageData.ratio;
	var _uvs = _imageData.subImagesArray[_imageIndex % _imageData.subImagesCount];
	_uvs.texturePageStruct.__restoreFromCache();
	
	if (__COLLAGE_AUTO_CHECK_TEXTURE_PAGES) _uvs.texturePageStruct.CheckSurface();	
	
	
	if (_ratio != 1) {
		draw_surface_part_ext(_uvs.texturePageStruct.__surface, _uvs.left, _uvs.top, _uvs.right, _uvs.bottom, _x+_uvs.xPos, _y+_uvs.yPos, 1/_ratio, 1/_ratio, c_white, 1);	
	} else {
		draw_surface_part(_uvs.texturePageStruct.__surface, _uvs.left, _uvs.top, _uvs.right, _uvs.bottom, _x+_uvs.xPos, _y+_uvs.yPos);	
	}
}
