if keyboard_check_pressed(vk_space) {
	texPage.AddFileStrip("spr_soldier.png", "spr_soldier");
}

if keyboard_check_released(vk_control) {
	texPage.FreePages();	
}
