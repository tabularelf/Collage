/// @func draw_image(sprite_index/image, image_index, x, y);
/// @param {Any} sprite_index/image
/// @param {Real} image_index
/// @param {Real} x
/// @param {Real} y
/* Feather ignore once GM1042 */
function draw_image(_sprite, _sub, _x, _y) {
	gml_pragma("forceinline");
	if (is_real(_sprite)) {
		draw_sprite(_sprite, _sub, _x, _y);
	} else {
		CollageDrawImage(_sprite, _sub, _x, _y);	
	} 
} 
