if (keyboard_check_released(vk_space)) {
	beginDraw = !beginDraw;	
}

if (keyboard_check_released(vk_control)) {
	batch.Clear();
	draw_texture_flush();
	CollageTextureFlush();
}