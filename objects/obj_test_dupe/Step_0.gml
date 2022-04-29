if keyboard_check_pressed(vk_space) {
	texPage2.addFileStrip("spr_soldier_long.png", "spr_soldier");
}

if keyboard_check_released(vk_control) {
	texPage2.destroy();	
}
