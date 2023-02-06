var _i = 0;
repeat(array_length(pos)) {
	draw_image(pos[0].image, 0, pos[_i].x, pos[_i].y);
	++_i;
}