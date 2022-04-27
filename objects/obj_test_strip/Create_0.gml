texPage = new Collage(2048, 2048, false, 0, "Test");
texPage.startBatch();
var _file = file_find_first("*.png", 0);
while (_file != "") {
	if (_file != "spr_soldier.png") texPage.addFile(_file);
	_file = file_find_next();
}
file_find_close();
texPage.addFileStrip("spr_soldier.png", undefined, undefined, undefined, 0, 0, true);

var _file = file_find_first("*.jpg", 0);
while (_file != "") {
	texPage.addFile(_file);
	_file = file_find_next();
}
file_find_close();
texPage.finishBatch();
