enum __CollageStates {
	NORMAL,
	BATCHING
}

enum __CollageStatus {
	READY,
	WAITING_ON_FILES
}

#macro __COLLAGE_CREDITS "@TabularElf - https://tabelf.link/"
#macro __COLLAGE_VERSION "v0.1.1"
show_debug_message("Collage " + __COLLAGE_VERSION + " Initalized! Created by " + __COLLAGE_CREDITS);

global.__CollageTexturePagesMap = {};
global.__CollageTexturePagesList = [];
global.__CollageImageMap = {};
global.__CollageGMSpriteCount = 0;
global.__CollageAsyncList = [];

var _i = 0;
while(sprite_exists(_i)) {
	global.__CollageGMSpriteCount = ++_i;
}


function __CollageTrace(_string) {
	show_debug_message("Collage: " + _string);
}

function __CollageThrow(_string) {
	show_error("Collage: Error!: " + _string, true);	
}
