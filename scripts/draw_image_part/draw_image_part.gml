/// @func draw_image_part(sprite_index/image, image_index, left, top, width, height, x, y);
/// @param {Any} sprite_index/image
/// @param {Real} image_index
/// @param {Real} left
/// @param {Real} top
/// @param {Real} width
/// @param {Real} height
/// @param {Real} x
/// @param {Real} y
/* Feather ignore once GM1042 */
function draw_image_part(_sprite, _sub, _left, _top, _width, _height, _x, _y) {
	gml_pragma("forceinline");
	if (is_real(_sprite)) {
		if (sprite_exists(_sprite)) {
			draw_sprite_part(_sprite, _sub, _left, _top, _width, _height, _x, _y);
		}
	} else {
		CollageDrawImagePart(_sprite, _sub, _left, _top, _width, _height, _x, _y);
	} 
} 
