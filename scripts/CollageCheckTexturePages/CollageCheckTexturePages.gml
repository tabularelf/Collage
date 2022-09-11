/// @func CollageCheckTexturePages()
function CollageCheckTexturePages() {
	gml_pragma("forceinline");
	if (__COLLAGE_AUTO_CHECK_TEXTURE_PAGES) exit;
	var _len = array_length(global.__CollageTexturePagesList);
	var _i = 0;
	repeat(_len) {
		var _texPage =  global.__CollageTexturePagesList[_i++];
		var _texArray = _texPage.__texPageArray;
		var _ii = 0;
		repeat( array_length(_texArray)) {
			/* Feather ignore once GM1061 */
			 _texArray[_ii++].CheckSurface();	
		}
	}
}
