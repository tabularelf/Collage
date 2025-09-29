
/*var _i = 0;
repeat(array_length(pos)) {
	draw_image(pos[_i].image, current_time / 1000, pos[_i].x, pos[_i].y);
	++_i;
}
*/

var _i = 0;
repeat(array_length(sprites)) {
	if (sprite_exists(sprites[_i])) {
		draw_image(sprites[_i], 0, pos[_i].x, pos[_i].y);
	}
	++_i;
}
