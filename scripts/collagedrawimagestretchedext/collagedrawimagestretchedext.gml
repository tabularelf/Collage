/// @func CollageDrawImageStretchedExt(image, image_index, x, y, width, height, color, alpha);
/// @param {Struct} image
/// @param {Real} image_index
/// @param {Real} x
/// @param {Real} y
/// @param {Real} width
/// @param {Real} height
/// @param {Real} color
/// @param {Real} alpha
/* Feather ignore once GM1042 */
function CollageDrawImageStretchedExt(_imageData, _imageIndex, _x, _y, _width, _height, _color, _alpha) {
	gml_pragma("forceinline");
	var _ratio = _imageData.ratio;
	var _uvs = _imageData.__InternalGetUvs(_imageIndex);
	_uvs.texturePageStruct.__restoreFromCache();
	
	_uvs.texturePageStruct.CheckSurface();	
	var _xOffset = -_uvs.xPos;
	var _yOffset = _uvs.yPos;
	var _rot = 0;
	var _xPos = lengthdir_x(_xOffset * _width, _rot) - lengthdir_x(_yOffset * _height, _rot - 90);
	var _yPos = lengthdir_y(_xOffset * _width, _rot) - lengthdir_y(_yOffset * _height, _rot - 90);
	draw_surface_part_ext(_uvs.texturePageStruct.__surface, _uvs.left, _uvs.top, _uvs.right, _uvs.bottom, _x+_xPos, _y+_yPos, (_width/_imageData.width)/_ratio, (_height/_imageData.height)/_ratio, _color, _alpha);	
}
