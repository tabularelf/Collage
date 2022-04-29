/// @func draw_image(sprite_index/image, image_index, x, y);
/// @param sprite_index/image
/// @param image_index
/// @param x
/// @param y
function draw_image(_sprite, _sub, _x, _y) {
	gml_pragma("forceinline");
	if (is_real(_sprite)) {
		draw_sprite(_sprite, _sub, _x, _y);
	} else {
		CollageDrawImage(_sprite, _sub, _x, _y);	
	} 
} 
