if keyboard_check_released(vk_space) {
	texPage.AddFile("https://tabelf.link/img/logo.gif");
}

if (texPage.Exists("logo")) {
	if (texPage.GetStatus() == CollageStatus.READY) {
		image = texPage.GetImageInfo("logo");	
	}
}
