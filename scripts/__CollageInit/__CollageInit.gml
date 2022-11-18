enum CollageStates {
	NORMAL,
	BATCHING
}

enum __CollagePageType {
	NORMAL,
	SEPARATE
}

enum CollageStatus {
	READY,
	WAITING_ON_FILES
}

enum CollageOrigin {
	LEFT = -2716284,
	CENTER,
	RIGHT,
	TOP,
	BOTTOM	
}

#macro __COLLAGE_CREDITS "@TabularElf - https://tabelf.link/"
#macro __COLLAGE_VERSION "v0.3.0-dev"
show_debug_message("Collage " + __COLLAGE_VERSION + " Initalized! Created by " + __COLLAGE_CREDITS);

/// @ignore
function __CollageInit() {
	static _init = false;
		// Feather ignore once GM1011
		if (!_init) {
			global.__CollageTexturePagesMap = {};
			global.__CollageTexturePagesList = [];
			global.__CollageImageMap = {};
			global.__CollageGMSpriteCount = 0;
			global.__CollageAsyncList = [];
			
			var _i = 0;
			while(sprite_exists(_i)) {
				global.__CollageGMSpriteCount = _i;
				++_i;
			}
			_init = true;
	}
}
__CollageInit();
