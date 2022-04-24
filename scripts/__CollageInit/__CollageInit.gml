enum __collageStates {
	NORMAL,
	BATCHING
}

#macro __COLLAGE_CREDITS "@TabularElf - https://tabelf.link/"
#macro __COLLAGE_VERSION "v0.1.0"
show_debug_message("Collage " + __COLLAGE_VERSION + " Initalized! Created by " + __COLLAGE_CREDITS);

global.__CollageTexturePagesMap = {};
global.__CollageTexturePagesList = [];
global.__CollageImageMap = {};
global.__CollageImageList = [];		


function __CollageTrace(_string) {
	show_debug_message("Collage: " + _string);
}

function __CollageThrow(_string) {
	show_error("Collage: Error!: " + _string, true);	
}
