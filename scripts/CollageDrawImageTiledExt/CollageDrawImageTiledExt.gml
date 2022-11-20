/// @func CollageDrawImageTiledExt(image, image_index, x, y);
/// @param {Struct} image
/// @param {Real} image_index
/// @param {Real} x
/// @param {Real} y
/// @param {Real} xscale
/// @param {Real} yscale
/// @param {Real} colour
/// @param {Real} alpha
/* Feather ignore once GM1042 */
function CollageDrawImageTiledExt(_imageData, _imageIndex, _x, _y, _xScale, _yScale, _col, _alpha) {
	gml_pragma("forceinline");
	var _ratio = _imageData.ratio;
	var _uvs = _imageData.__InternalGetUvs(_imageIndex);
	_uvs.texturePageStruct.__restoreFromCache();
	
	_uvs.texturePageStruct.CheckSurface();	
	
	var _xPos = _x-_uvs.xPos;
	var _yPos = _y-_uvs.yPos;
	var _xRatio = max(0.01, _xScale/_ratio);
	var _yRatio = max(0.01, _yScale/_ratio);
	var _bboxLeft = _uvs.left;
	var _bboxTop = _uvs.top;
	var _bboxRight = _uvs.right;
	var _bboxBottom = _uvs.bottom;
	var _bboxWidth = _uvs.originalWidth;
	var _bboxHeight = _uvs.originalHeight;
	var _surface = _uvs.texturePageStruct.__surface;
	
	var _i = 0;
	var _j = 0;
	var _viewCam = view_camera[view_current];
	var _w = camera_get_view_width(_viewCam);
	var _h = camera_get_view_height(_viewCam);
	
	repeat((_w div (_bboxWidth * _xRatio))+1) {
		_j = 0;
		repeat((_h div abs(_bboxHeight * _yRatio))+1) {
			draw_surface_part_ext(_surface, 
				_bboxLeft,
				_bboxTop,
				_bboxRight,
				_bboxBottom, 
				_xPos + ((_i * _bboxWidth) * _xRatio), 
				_yPos + ((_j * _bboxHeight) * _yRatio), 
				_xRatio, 
				_yRatio, 
				_col, 
				_alpha
			);		
			++_j;
		}	
		++_i;
	}
}
