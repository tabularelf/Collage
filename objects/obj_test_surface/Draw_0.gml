if (texPage.Exists("test")) {
	//draw_image(texPage.GetImageInfo("test"), current_time/100, 8, 8);
	draw_surface(texPage.GetImageInfo("test").GetUVs(0).texturePageStruct.GetSurface(), 0, 0);
}

//draw_surface(surf2, 256, 256);