/// @func draw_image_ext(sprite_index/collage_imagemage, image_index, x, y, xscale, yscale, rot, col, alpha);
/// @param {Asset.GMSprite, Struct.__CollageImageClass} sprite_index/collage_image
/// @param {Real} image_index
/// @param {Real} x
/// @param {Real} y
/// @param {Real} xscale
/// @param {Real} yscale
/// @param {Real} rot
/// @param {Real} col
/// @param {Real} alpha
/* Feather ignore all */
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
