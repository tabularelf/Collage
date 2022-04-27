var _i = 0;
repeat(array_length(pos)) {
	CollageDrawImage(pos[_i].image, current_time / 100, pos[_i].x, pos[_i].y);	
	++_i;
}
