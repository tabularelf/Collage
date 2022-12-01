/// @func draw_image_stretched_ext(sprite_index/collage_image, image_index, x, y, width, height, col, alpha)
/// @param {Asset.GMSprite, Struct.__CollageImageClass} sprite_index/collage_image
/// @param {Real} image_index
/// @param {Real} x
/// @param {Real} y
/// @param {Real} width
/// @param {Real} height
/// @param {Real} color
/// @param {Real} alpha
/* Feather ignore all */
function draw_image_stretched_ext(_sprite, _sub, _x, _y, _width, _height, _col, _alpha) {
	gml_pragma("forceinline");
	if (is_real(_sprite)) {
		draw_sprite_stretched_ext(_sprite, _sub, _x, _y, _width, _height, _col, _alpha);	
	} else {
		CollageDrawImageStretchedExt(_sprite, _sub, _x, _y, _width, _height, _col, _alpha);	
	} 
} 
