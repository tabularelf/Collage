/// @func CollageDrawImagePart(image, image_index, x, y);
/// @param {Struct.__CollageImageClass} collage_image
/// @param {Real} image_index
/// @param {Real} left
/// @param {Real} right
/// @param {Real} width
/// @param {Real} height
/// @param {Real} x
/// @param {Real} y
/* Feather ignore all */
function CollageDrawImagePart(_imageData, _imageIndex, _left, _top, _width, _height, _x, _y) {
	gml_pragma("forceinline");
	if (!is_struct(_imageData)) __CollageThrow("Invalid collage_image! Got " + string(_imageData) + " instead!");
	var _ratio = _imageData.__ratio;
	var _uvs = _imageData.__InternalGetUvs(_imageIndex);
	
	_uvs.texturePageStruct.CheckSurface();	
	
	if (_ratio != 1) {
		draw_surface_part_ext(
			_uvs.texturePageStruct.__surface, 
			_uvs.left + _left, 
			_uvs.top + _top, 
			_width, 
			_height, 
			_x-_uvs.xPos, 
			_y-_uvs.yPos, 
			1/_ratio, 
			1/_ratio, 
			c_white, 
			1
		);	
	} else {
		draw_surface_part(
			_uvs.texturePageStruct.__surface, 
			_uvs.left + _left, 
			_uvs.top + _top, 
			_width,
			_height, 
			_x-_uvs.xPos, 
			_y-_uvs.yPos
		);	
	}
}
