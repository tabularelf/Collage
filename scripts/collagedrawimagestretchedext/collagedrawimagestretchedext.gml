/// @func CollageDrawImageStretchedExt(image, image_index, x, y, width, height, color, alpha);
/// @param {Struct.__CollageImageClass} collage_image
/// @param {Real} image_index
/// @param {Real} x
/// @param {Real} y
/// @param {Real} width
/// @param {Real} height
/// @param {Real} color
/// @param {Real} alpha
/* Feather ignore all */
function CollageDrawImageStretchedExt(_imageData, _imageIndex, _x, _y, _width, _height, _color, _alpha) {
	gml_pragma("forceinline");
	var _ratio = _imageData.__ratio;
	var _uvs = _imageData.__InternalGetUvs(_imageIndex);
	_uvs.texturePageStruct.__restoreFromCache();
	
	_uvs.texturePageStruct.CheckSurface();	
	var _xOffset = _uvs.xPos;
	var _yOffset = _uvs.yPos;
	draw_surface_part_ext(_uvs.texturePageStruct.__surface, 
		_uvs.left, 
		_uvs.top, 
		_uvs.right, 
		_uvs.bottom, 
		_x, 
		_y, 
		(_width/_imageData.width)/_ratio, 
		(_height/_imageData.height)/_ratio, 
		_color, 
		_alpha
	);	
}
