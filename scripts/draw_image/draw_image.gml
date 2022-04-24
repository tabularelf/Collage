/// @func draw_image(sprite_index/collage_sprite_index, image_index, x, y);
/// @param sprite_index/image
/// @param image_index
/// @param x
/// @param y
function draw_image(_sprite, _sub, _x, _y) {
	if (is_real(_sprite)) {
		draw_sprite(_sprite, _sub, _x, _y);
	} else if (is_struct(_sprite)) {
		CollageDrawImage(_sprite, _sub, _x, _y);	
	} else {
		__CollageThrow(string(_sprite) + " is not a valid GM Sprite or Collage image!");	
	}
} 
