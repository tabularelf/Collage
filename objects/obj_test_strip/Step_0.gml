if keyboard_check_pressed(vk_space) {
	texPage.AddFileStrip("https://tabelf.link/img/logo.gif", "spr_soldier");
}

if keyboard_check_released(vk_control) {
	texPage.FreePages();	
}
