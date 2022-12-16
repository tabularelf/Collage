texPage = new Collage();
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

var _images = texPage.ImagesToArray();
pos = array_create(array_length(_images));
var _i = 0;
repeat(array_length(_images)) {
	pos[_i] = {image: _images[_i], x: random(room_width-128), y: random(room_height-128)};
	++_i;
}