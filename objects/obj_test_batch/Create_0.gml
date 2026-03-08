texPage = new Collage("Test",,,,,false);
texPage.StartBatch();
texPage.AddFile("spr_soldier_copy.png", "Bob", 4, false, false, CollageOrigin.CENTER, CollageOrigin.CENTER);
texPage.AddFile("spr_soldier_copy.png", "Bob2", 4, false, false, CollageOrigin.CENTER, CollageOrigin.CENTER);
texPage.AddFile("IMAGE_NORMAL.png",, 1, false, false, CollageOrigin.CENTER, CollageOrigin.CENTER);
texPage.AddFile("IMAGE_WITH_SPACE.png",, 1, false, false, CollageOrigin.CENTER, CollageOrigin.CENTER);
texPage.AddFile("IMAGE_WITH_SPACE2.png",, 1, false, false, CollageOrigin.CENTER, CollageOrigin.CENTER);
var _file = file_find_first("*.png", fa_none);
var _i = 0;
while (_file != "") {
	texPage.AddFile(_file,, 1, false, false, CollageOrigin.CENTER, CollageOrigin.CENTER);	
	_file = file_find_next();
	++_i;
}
file_find_close();
texPage.FinishBatch();

//texPage.AddFile("https://media1.tenor.com/m/9eeQ9LmAexsAAAAd/shaking-cat-shaking.gif",, 1, false, false, 0, 0, 0);

var _images = texPage.ImagesToArray();
pos = array_create(array_length(_images));
_i = 0;
repeat(array_length(_images)) {
	pos[_i] = {image: _images[_i], x: random(room_width-128), y: random(room_height-128)};
	++_i;
}	

var _buff = texPage.Export();

//texPageStatic = texPage.ToStaticBuilder();
//var _path = $".collage/{texPageStatic.GetName()}_0.png";
//surface_save(texPageStatic.NextPage().GetSurface(), _path);
//texPageStatic.AddPath(_path);
//texPageStatic = texPageStatic.Finalize();
//sprites = texPageStatic.GetSprites();
show_debug_overlay(true, true);
//texPage.SaveAsPNGs("data/");

//show_debug_message(json_stringify(texPage.ExportData(), true));
//show_debug_message(texPage.ToJSON(true));
//texPage.SaveAsPNGs("TestFolder");
texPageStatic = texPage.ToStatic(true);
	sprites = texPageStatic.GetSprites();
			sprite_index = sprites[0];
		show_debug_message("Static page generated!");
	call_later(1, time_source_units_seconds, function() {
		//show_debug_message("Dynamic page destroyed!");
		//texPageStatic.Destroy();
		//texturegroup_delete("Test");
	});
show_debug_overlay(true);

//var _i = 0;
//repeat(array_length(sprites)) {
//	show_debug_message($"{sprite_get_name(sprites[_i])} {sprite_get_xoffset(sprites[_i])} {sprite_get_yoffset(sprites[_i])}");
//	++_i;	
//}