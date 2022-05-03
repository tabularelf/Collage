if keyboard_check_released(vk_space) {
	texPage.AddFile("https://gamemakerkitchen.com/assets/img/cathehehe.gif");
}

if (texPage.Exists("cathehehe")) {
	if (texPage.GetStatus() == CollageStatus.READY) {
		image = texPage.GetImageInfo("cathehehe");	
	}
}
