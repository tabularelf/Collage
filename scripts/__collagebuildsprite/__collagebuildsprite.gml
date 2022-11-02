/// @ignore
// Feather ignore all
function __CollageBuildSprite(_imageData, _x, _y, _z, _widthValue = 0, _heightValue = 0, _uvs, _colour = draw_get_color(), _alpha = draw_get_alpha()){
	static _vFormat = undefined;
	if (is_undefined(_vFormat)) {
		vertex_format_begin();
		vertex_format_add_position_3d();
		vertex_format_add_colour();
		vertex_format_add_texcoord();
		_vFormat = vertex_format_end();	
	}
	
	static __currentVertexBatch = vertex_create_buffer();
	var __currentTexturePage = _uvs.texturePageStruct.GetTexture();
	vertex_begin(__currentVertexBatch, _vFormat);
	
	// Get UV info
	var _left, _right, _top, _bottom, _x1, _y1;
	_left =			_uvs.normLeft; 
	_top =			_uvs.normTop;
	_right =		_uvs.normRight;
	_bottom =	_uvs.normBottom; 
	_x1 = _x + _uvs.xPos;
	_y1 = _y + _uvs.yPos;
	var _width = _imageData.cropWidth;
	var _height = _imageData.cropHeight;
	var _x2 = _x1 + _width;
	var _y2 = _y1 + _height;
	
	// Add vertices
	vertex_position_3d(__currentVertexBatch, _x1, _y1, _z);
	vertex_color(__currentVertexBatch, _colour, _alpha);
	vertex_texcoord(__currentVertexBatch, _left, _top);
	
	vertex_position_3d(__currentVertexBatch, _x2+_widthValue, _y1, _z);
	vertex_color(__currentVertexBatch, _colour, _alpha);
	vertex_texcoord(__currentVertexBatch, _right, _top);
	
	vertex_position_3d(__currentVertexBatch, _x1, _y2+_heightValue, _z);
	vertex_color(__currentVertexBatch, _colour, _alpha);
	vertex_texcoord(__currentVertexBatch, _left, _bottom);
	
	
	vertex_position_3d(__currentVertexBatch, _x2+_widthValue, _y1, _z);
	vertex_color(__currentVertexBatch, _colour, _alpha);
	vertex_texcoord(__currentVertexBatch, _right, _top);
	
	vertex_position_3d(__currentVertexBatch, _x1, _y2+_heightValue, _z);
	vertex_color(__currentVertexBatch, _colour, _alpha);
	vertex_texcoord(__currentVertexBatch, _left, _bottom);
	
	vertex_position_3d(__currentVertexBatch, _x2+_widthValue, _y2+_heightValue, _z);
	vertex_color(__currentVertexBatch, _colour, _alpha);
	vertex_texcoord(__currentVertexBatch, _right, _bottom);
	
	vertex_end(__currentVertexBatch);
	vertex_submit(__currentVertexBatch, pr_trianglelist, __currentTexturePage);
}