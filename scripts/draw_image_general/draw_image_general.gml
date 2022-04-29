/// @func draw_image_general(sprite_index/image, image_index, left, top, width, height, x, y, xscale, yscale, rot, col1, col2, col3, col4, alpha);
/// @param sprite_index/image
/// @param image_index
/// @param left
/// @param top
/// @param width
/// @param height
/// @param x
/// @param y
/// @param xscale
/// @param yscale
/// @param rot
/// @param col1
/// @param col2
/// @param col3
/// @param col4
/// @param alpha
function draw_image_general(_sprite, _sub, _left, _top, _width, _height, _x, _y, _xScale, _yScale, _rot, _col1, _col2, _col3, _col4, _alpha) {
	gml_pragma("forceinline");
	if (is_real(_sprite)) {
		if (sprite_exists(_sprite)) {
			draw_sprite_general(_sprite, _sub, _left, _top, _width, _height, _x, _y, _xScale, _yScale, _rot, _col1, _col2, _col3, _col4, _alpha);
		}
	} else {
		CollageDrawImageGeneral(_sprite, _sub, _left, _top, _width, _height, _x, _y, _xScale, _yScale, _rot, _col1, _col2, _col3, _col4, _alpha);	
	} 
} 
