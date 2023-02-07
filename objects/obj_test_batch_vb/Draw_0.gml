if (beginDraw) {
	var _i = 0;
	var _time = current_time / 100;
	var _col = [make_colour_hsv((_time+128) % 256, 255, 255), make_colour_hsv((_time+128+128) % 256, 255, 255), make_colour_hsv((_time+128+128+128) % 256, 255, 255), make_colour_hsv((_time+128+128+128+128) % 256, 255, 255)];
	batch.StartAppend();
	repeat(array_length(pos)) {
		batch.AddImage(pos[_i].image, current_time / 100, pos[_i].x, pos[_i].y, 0, scaleSin, scaleSin, angle, _col);
		++_i;
	}
	batch.Finish();
	angle += .45;
	scale += .04;
	scaleSin = sin(scale);
}
batch.Draw();	

draw_text(8, 16, batch.GetBatchCount());