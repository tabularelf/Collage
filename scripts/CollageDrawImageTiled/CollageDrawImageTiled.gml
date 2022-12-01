/// @func CollageDrawImageTiled(image, image_index, x, y);
/// @param {Struct.__CollageImageClass} collage_image
/// @param {Real} image_index
/// @param {Real} x
/// @param {Real} y
/* Feather ignore all */
function CollageDrawImageTiled(_imageData, _imageIndex, _x, _y) {
	gml_pragma("forceinline");
	var _ratio = _imageData.__ratio;
	var _uvs = _imageData.__InternalGetUvs(_imageIndex);
	_uvs.texturePageStruct.__restoreFromCache();
	
	_uvs.texturePageStruct.CheckSurface();	
	
	var _xPos = _x-_uvs.xPos;
	var _yPos = _y-_uvs.yPos;
	var _scale = 1/_ratio;
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
	repeat((_w div _bboxWidth)+1) {
		_j = 0;
		repeat((_h div _bboxHeight)+1) {
			draw_surface_part_ext(_surface, 
				_bboxLeft,
				_bboxTop,
				_bboxRight,
				_bboxBottom, 
				_xPos + ((_i * _bboxWidth) * _scale), 
				_yPos + ((_j * _bboxHeight) * _scale), 
				_scale, 
				_scale, 
				c_white, 
				1
			);		
			++_j;
		}	
		++_i;
	}
}
