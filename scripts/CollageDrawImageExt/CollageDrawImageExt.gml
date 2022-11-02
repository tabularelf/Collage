/// @func CollageDrawImageExt(image, image_index, x, y, xscale, yscale, rot, col, alpha);
/// @param {Struct} image
/// @param {Real} image_index
/// @param {Real} x
/// @param {Real} y
/// @param {Real} xscale
/// @param {Real} yscale
/// @param {Real} rot
/// @param {Real} col
/// @param {Real} alpha
/* Feather ignore once GM1042 */
function CollageDrawImageExt(_imageData, _imageIndex, _x, _y, _xScale, _yScale, _rot, _col, _alpha) {
	gml_pragma("forceinline");
	var _ratio = _imageData.ratio;
	var _uvs = _imageData.__InternalGetUvs(_imageIndex);
	_uvs.texturePageStruct.__restoreFromCache();
	
	_uvs.texturePageStruct.CheckSurface();	
	var _xOffset = -_uvs.xPos;
	var _yOffset = _uvs.yPos;
	var _xPos = lengthdir_x(_xOffset * _xScale, _rot) - lengthdir_x(_yOffset * _yScale, _rot - 90);
	var _yPos = lengthdir_y(_xOffset * _xScale, _rot) - lengthdir_y(_yOffset * _yScale, _rot - 90);
	draw_surface_general(_uvs.texturePageStruct.__surface, _uvs.left, _uvs.top, _uvs.right, _uvs.bottom, _x-_xPos, _y-_yPos, _xScale/_ratio, _yScale/_ratio, _rot, _col, _col, _col, _col, _alpha);	
}
