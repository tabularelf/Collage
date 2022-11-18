/// @func CollageDrawImagePartExt(image, image_index, x, y);
/// @param {Struct} image
/// @param {Real} image_index
/// @param {Real} left
/// @param {Real} right
/// @param {Real} width
/// @param {Real} height
/// @param {Real} x
/// @param {Real} y
/// @param {Real} xscale
/// @param {Real} yscale
/// @param {Real} colour
/// @param {Real} alpha
/* Feather ignore once GM1042 */
function CollageDrawImagePartExt(_imageData, _imageIndex, _left, _top, _width, _height, _x, _y, _xScale, _yScale, _col, _alpha) {
	gml_pragma("forceinline");
	var _ratio = _imageData.ratio;
	var _uvs = _imageData.__InternalGetUvs(_imageIndex);
	_uvs.texturePageStruct.__restoreFromCache();
	
	_uvs.texturePageStruct.CheckSurface();	
	
	draw_surface_part_ext(
		_uvs.texturePageStruct.__surface, 
		_uvs.left + _left, 
		_uvs.top + _top, 
		_width, 
		_height, 
		_x-_uvs.xPos, 
		_y-_uvs.yPos, 
		_xScale/_ratio, 
		_yScale/_ratio, 
		_col, 
		_alpha
	);	
}
