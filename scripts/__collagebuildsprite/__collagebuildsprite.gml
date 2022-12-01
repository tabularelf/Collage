/// @ignore
/* Feather ignore all */
function __CollageBuildSprite(_vbuffer, _imageData, _index, _x, _y, _z, _widthValue = 1, _heightValue = 1, _colourValue = draw_get_color(), _alpha = draw_get_alpha()){
	var _uvs = _imageData.GetUVs(_index);
	
	// Get UV info
	var _left, _right, _top, _bottom, _x1, _y1;
	_left =			_uvs.normLeft; 
	_top =			_uvs.normTop;
	_right =		_uvs.normRight;
	_bottom =	_uvs.normBottom; 
	_x1 = _x + _uvs.xPos;
	_y1 = _y + _uvs.yPos;
	static __array = array_create(4);
	var _colour;
	if (is_array(_colourValue)) {
		_colour = _colourValue;	
	} else if (is_real(_colourValue)) {
		__array[0] =_colourValue;
		__array[1] =_colourValue;
		__array[2] =_colourValue;
		__array[3] =_colourValue;
		_colour = __array;
	}
	var _width = _imageData.cropWidth;
	var _height = _imageData.cropHeight;
	var _x2 = _x1 + _width;
	var _y2 = _y1 + _height;
	
	// Add vertices
	vertex_position_3d(_vbuffer, _x1, _y1, _z);
	vertex_color(_vbuffer, _colour[0], _alpha);
	vertex_texcoord(_vbuffer, _left, _top);
	
	vertex_position_3d(_vbuffer, _x2+_widthValue, _y1, _z);
	vertex_color(_vbuffer, _colour[1], _alpha);
	vertex_texcoord(_vbuffer, _right, _top);
	
	vertex_position_3d(_vbuffer, _x1, _y2+_heightValue, _z);
	vertex_color(_vbuffer, _colour[3], _alpha);
	vertex_texcoord(_vbuffer, _left, _bottom);
	
	
	vertex_position_3d(_vbuffer, _x2+_widthValue, _y1, _z);
	vertex_color(_vbuffer, _colour[1], _alpha);
	vertex_texcoord(_vbuffer, _right, _top);
	
	vertex_position_3d(_vbuffer, _x1, _y2+_heightValue, _z);
	vertex_color(_vbuffer, _colour[3], _alpha);
	vertex_texcoord(_vbuffer, _left, _bottom);
	
	vertex_position_3d(_vbuffer, _x2+_widthValue, _y2+_heightValue, _z);
	vertex_color(_vbuffer, _colour[2], _alpha);
	vertex_texcoord(_vbuffer, _right, _bottom);
}