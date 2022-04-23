enum __collageStates {
	NORMAL,
	BATCHING
}

#macro __COLLAGE_CREDITS "@TabularElf - https://tabelf.link/"
#macro __COLLAGE_VERSION "v0.0.1"
show_debug_message("Collage " + __COLLAGE_VERSION + " Initalized! Created by " + __COLLAGE_CREDITS);

function __CollageInit() {
	static _init = false;
	if (!_init) {
		global.__CollageTexturePagesMap = {};
		global.__CollageTexturePagesList = [];
		global.__CollageImageMap = {};
		global.__CollageImageList = [];		
		_init = true;
	}
}

__CollageInit();

function __CollageTrace(_string) {
	show_debug_message("Collage: " + _string);
}

function __CollageThrow(_string) {
	show_error("Collage: Error!: " + _string, true);	
}

function CollageCheckTexturePages() {
	var _len = array_length(global.__CollageTexturePagesList);
	var _i = 0;
	repeat(_len) {
		global.__CollageTexturePagesList[_i++].checkSurface();	
	}
}
