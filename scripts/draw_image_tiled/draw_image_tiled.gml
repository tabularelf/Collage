/// @func draw_image_tiled(sprite_index/collage_image, image_index, x, y)
/// @param {Asset.GMSprite, Struct.__CollageImageClass} sprite_index/collage_image
/// @param {Real} image_index
/// @param {Real} x
/// @param {Real} y
/* Feather ignore all */
function draw_image_tiled(_sprite, _sub, _x, _y) {
	gml_pragma("forceinline");
	if (is_real(_sprite)) {
		draw_sprite_tiled(_sprite, _sub, _x, _y);
	} else {
		CollageDrawImageTiled(_sprite, _sub, _x, _y);	
	} 
} 
