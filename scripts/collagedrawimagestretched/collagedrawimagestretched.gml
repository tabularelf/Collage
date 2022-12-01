/// @func CollageDrawImageStretched(image, image_index, x, y, width, height);
/// @param {Struct.__CollageImageClass} collage_image
/// @param {Real} image_index
/// @param {Real} x
/// @param {Real} y
/// @param {Real} width
/// @param {Real} height
/* Feather ignore all */
function CollageDrawImageStretched(_imageData, _imageIndex, _x, _y, _width, _height) {
	gml_pragma("forceinline");
	var _ratio = _imageData.__ratio;
	var _uvs = _imageData.__InternalGetUvs(_imageIndex);
	_uvs.texturePageStruct.__restoreFromCache();
	
	_uvs.texturePageStruct.CheckSurface();	

	draw_surface_part_ext(_uvs.texturePageStruct.__surface, 
		_uvs.left, 
		_uvs.top, 
		_uvs.right, 
		_uvs.bottom, 
		_x+_uvs.xPos, 
		_y+_uvs.yPos, 
		(_width/_imageData.width)/_ratio, 
		(_height/_imageData.height)/_ratio, 
		c_white, 
		1
	);	
}