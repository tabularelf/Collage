function buildVBO(_vbuff, _format, _uvs, _x = 0, _y = 0) {
	vertex_begin(_vbuff, _format);
	var _x1 = _x - sprite_get_xoffset(spr_soldier);
	var _y1 = _y - sprite_get_yoffset(spr_soldier);
	var _x2 = _x1 + sprite_get_width(spr_soldier);
	var _y2 = _y1 + sprite_get_height(spr_soldier);
	
	// Triangle 1
	vertex_position(_vbuff, _x1, _y1);
	vertex_texcoord(_vbuff, _uvs[0], _uvs[1]);
	vertex_color(_vbuff, c_white, 1);
	
	vertex_position(_vbuff, _x2, _y1);
	vertex_texcoord(_vbuff, _uvs[2], _uvs[1]);
	vertex_color(_vbuff, c_white, 1);

	vertex_position(_vbuff, _x1, _y2);
	vertex_texcoord(_vbuff, _uvs[0], _uvs[3]);
	vertex_color(_vbuff, c_white, 1);

	// Triangle 2
	vertex_position(_vbuff, _x2, _y1);
	vertex_texcoord(_vbuff, _uvs[2], _uvs[1]);
	vertex_color(_vbuff, c_white, 1);
	
	vertex_position(_vbuff, _x1, _y2);
	vertex_texcoord(_vbuff, _uvs[0], _uvs[3]);
	vertex_color(_vbuff, c_white, 1);
	
	vertex_position(_vbuff, _x2, _y2);
	vertex_texcoord(_vbuff, _uvs[2], _uvs[3]);
	vertex_color(_vbuff, c_white, 1);
	vertex_end(_vbuff);
}