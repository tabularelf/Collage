texPage = new Collage("Test");
//texPage.StartBatch();
//var _file = file_find_first("*.png", fa_none);
//var _i = 0;
//while (_file != "") {
//	texPage.AddFile(_file,, 1, false, false, 0, 0);	
//	_file = file_find_next();
//	++_i;
//}
//file_find_close();
texPage.AddFile("IMAGE_WITH_SPACE.png",, 1, false, false);
//texPage.AddFile("IMAGE_WITH_SPACE.png",, 1, false, false);
//texPage.AddFile("IMAGE_WITH_SPACE.png",, 1, false, false);
//texPage.AddFile("IMAGE_WITH_SPACE.png",, 1, false, false);

/*var _image = texPage.AddEmptyImage("Test");
repeat(5) {
	var _sprite = sprite_add("IMAGE_WITH_SPACE_apart_half.png", 2, false, false, 0, 0);
	_image.AddSpriteAsFrame(_sprite);
}*/
//texPage.FinishBatch();

staticTex = texPage.ToStatic(true, false);
sprites = staticTex.GetSprites();
