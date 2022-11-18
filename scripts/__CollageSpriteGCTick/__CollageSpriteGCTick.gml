function __CollageSpriteGCTick() {
	var _i = 0;
	repeat(array_length(global.__CollageSpriteGCList)) {
		sprite_delete(global.__CollageSpriteGCList[_i]);
		++_i;
	}
	
	if (array_length(global.__CollageSpriteGCList) > 0) {
		array_resize(global.__CollageSpriteGCList, 0);	
	}
}