/// @func draw_image_ext(sprite_index/collage_sprite_index, image_index, x, y, xscale, yscale, rot, col, alpha);
/// @param sprite_index/collage_sprite_index
/// @param image_index
/// @param x
/// @param y
/// @param xscale
/// @param yscale
/// @param rot
/// @param col
/// @param alpha
function draw_image_ext(_sprite, _sub, _x, _y, _xscale, _yscale, _rot, _col, _alpha) {
	if (is_real(_sprite)) {
		if (sprite_exists(_sprite)) {
			draw_sprite_ext(_sprite, _sub, _x, _y, _xscale, _yscale, _rot, _col, _alpha);
		}
	} else if (is_struct(_sprite)) {
		CollageDrawImageExt(_sprite, _sub, _x, _y, _xscale, _yscale, _rot, _col, _alpha);	
	} else {
		show_error(string(_sprite) + " is not a valid sprite or Collage image!", true);	
	}
} 
