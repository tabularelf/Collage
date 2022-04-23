/* 
    |\__/,|   (`\
  _.|o o  |_   ) )
-(((---(((--------
Cat Judges your code
*/



/*vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_colour();
vertex_format_add_texcoord();
global.__tgmvertexFormat = vertex_format_end();

function CollageDrawImageTest(_imageData, _imageIndex, _x, _y, _z = 0) {
	gml_pragma("forceinline");
	var _count = _imageData.subImagesCount;
	var _uvs = _imageData.subImagesArray[_imageIndex % _count];
	if (buffer_exists(_uvs.texturePageStruct.cacheBuffer)) {
		_uvs.texturePageStruct.__restoreFromCache();	
	}
	var _texturePage = _uvs.texturePageStruct.surface;
	
	// Fetch data
	var __currentTexturePage = surface_get_texture(_texturePage);
	static __currentVertexBatch = vertex_create_buffer();
	vertex_begin(__currentVertexBatch, global.__tgmvertexFormat);
	
	// Get UV info
	var _left, _right, _top, _bottom, _x1, _y1;
	_left =			_uvs.normLeft; 
	_top =			_uvs.normTop;
	_right =		_uvs.normRight;
	_bottom =	_uvs.normBottom; 
	_x1 =_x + _uvs.xPos;
	_y1 =_y + _uvs.yPos;
	var _width = _imageData.cropWidth;
	var _height = _imageData.cropHeight;
	var _x2 = _x1 + _width;
	var _y2 = _y1 + _height;
	var _colour = draw_get_color();
	var _alpha = draw_get_alpha();
	
	// Add vertices
	vertex_position_3d(__currentVertexBatch, _x1, _y1, _z);
	vertex_color(__currentVertexBatch, _colour, _alpha);
	vertex_texcoord(__currentVertexBatch, _left, _top);
	
	vertex_position_3d(__currentVertexBatch, _x2, _y1, _z);
	vertex_color(__currentVertexBatch, _colour, _alpha);
	vertex_texcoord(__currentVertexBatch, _right, _top);
	
	vertex_position_3d(__currentVertexBatch, _x1, _y2, _z);
	vertex_color(__currentVertexBatch, _colour, _alpha);
	vertex_texcoord(__currentVertexBatch, _left, _bottom);
	
	
	vertex_position_3d(__currentVertexBatch, _x2, _y1, _z);
	vertex_color(__currentVertexBatch, _colour, _alpha);
	vertex_texcoord(__currentVertexBatch, _right, _top);
	
	vertex_position_3d(__currentVertexBatch, _x1, _y2, _z);
	vertex_color(__currentVertexBatch, _colour, _alpha);
	vertex_texcoord(__currentVertexBatch, _left, _bottom);
	
	vertex_position_3d(__currentVertexBatch, _x2, _y2, _z);
	vertex_color(__currentVertexBatch, _colour, _alpha);
	vertex_texcoord(__currentVertexBatch, _right, _bottom);
	
	vertex_end(__currentVertexBatch);
	vertex_submit(__currentVertexBatch, pr_trianglelist, __currentTexturePage);
}*/