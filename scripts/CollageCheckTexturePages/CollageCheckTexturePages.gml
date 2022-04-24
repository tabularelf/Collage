/// @func CollageCheckTexturePages()
function CollageCheckTexturePages() {
	var _len = array_length(global.__CollageTexturePagesList);
	var _i = 0;
	repeat(_len) {
		global.__CollageTexturePagesList[_i++].checkSurface();	
	}
}
