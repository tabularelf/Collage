if keyboard_check_pressed(vk_space) {
	texPage.addFileStrip("spr_soldier_long.png", "spr_soldier", undefined, undefined, 0, 0, true);
}

if keyboard_check_released(vk_control) {
	texPage.destroy();	
}
