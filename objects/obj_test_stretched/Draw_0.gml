if (texPage.Exists("spr_soldier")) {
	var _info = texPage.GetImageInfo("spr_soldier");
	draw_image_stretched(_info, current_time/100, 50, 50, 100, 100);	
}
