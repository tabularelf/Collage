/// @func draw_image_ext(sprite_index/image, image_index, x, y, xscale, yscale, rot, col, alpha);
/// @param sprite_index/image
/// @param image_index
/// @param x
/// @param y
/// @param xscale
/// @param yscale
/// @param rot
/// @param col
/// @param alpha
function draw_image_ext(_sprite, _sub, _x, _y, _xscale, _yscale, _rot, _col, _alpha) {
	gml_pragma("forceinline");
	if (is_real(_sprite)) {
		if (sprite_exists(_sprite)) {
			draw_sprite_ext(_sprite, _sub, _x, _y, _xscale, _yscale, _rot, _col, _alpha);
		}
	} else {
		CollageDrawImageExt(_sprite, _sub, _x, _y, _xscale, _yscale, _rot, _col, _alpha);	
	} 
} 
