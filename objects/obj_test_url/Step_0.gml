if keyboard_check_released(vk_space) {
	texPage.addFile("https://gamemakerkitchen.com/assets/img/cathehehe.gif");
}

if (CollageImageExists("cathehehe")) {
	if (texPage.getStatus() == __CollageStatus.READY) {
		image = texPage.imagesToArray()[0];	
	}
}
