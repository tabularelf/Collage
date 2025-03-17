texPage = new Collage(,,,,,false);
texPage.StartBatch();


var _file = file_find_first("*.png", 0);
var _i = 0;

while (_file != "") {
	texPage.AddFile(_file,, 1, false, false, CollageOrigin.CENTER, CollageOrigin.CENTER);		
	_file = file_find_next();
	++_i;
}

file_find_close();
texPage.FinishBatch();
texPage.AddSprite(spr_soldier, "test");

var _images = texPage.ImagesToArray();

pos = array_create(array_length(_images));
_i = 0;

repeat(array_length(_images)) {
	pos[_i] = {image: _images[_i], x: random(room_width-128), y: random(room_height-128)};
	++_i;
}	

show_debug_overlay(true);
beginDraw = false;
angle = 0;
scale = 1;
scaleSin = 1;

batch = new CollageRenderPipeline();

var _i = 0;
batch.Start();

repeat(array_length(pos)) {
	batch.AddImage(pos[_i].image, 0, pos[_i].x, pos[_i].y, 0, scaleSin, scaleSin, angle);
	++_i;
}

batch.Finish();

// Example removing an image
batch.RemoveImageByIndex(0, 0);

batch.Freeze();

sprite_index = texPage.GetImageInfo("test").ToSprite();