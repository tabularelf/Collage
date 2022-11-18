texPage = new Collage();
texPage.StartBatch();
var _file = file_find_first("*.png", 0);
while (_file != "") {
	texPage.AddFile(_file,, 1, false, false, CollageOrigin.CENTER, CollageOrigin.CENTER);
	_file = file_find_next();
}
file_find_close();

/*var _file = file_find_first("*.jpg", 0);
while (_file != "") {
	texPage.AddFile(_file);
	_file = file_find_next();
}
file_find_close();*/
texPage.FinishBatch();

images = texPage.ImagesToArray();
pos = array_create(array_length(images));
var _i = 0;
repeat(array_length(images)) {
	pos[_i] = {image: images[_i], x: random(room_width-128), y: random(room_height-128)};
	++_i;
}
