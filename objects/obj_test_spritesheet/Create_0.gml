show_debug_overlay(true);
texPage = new Collage("Spritesheet",,, true);
var _batSprite = sprite_add("bats.png", 1, false, false, 0, 0);
var _array = [
	CollageDefineSpriteForSheet("_fly_down", 32, 0, 128, 32),
	CollageDefineSpriteForSheet("_fly_right", 32, 32, 128, 32),
	CollageDefineSpriteForSheet("_fly_up", 32, 64, 128, 32),
	CollageDefineSpriteForSheet("_fly_left", 32, 96, 128, 32),
	CollageDefineSpriteForSheet("_dead_down", 0, 0, 32, 32),
	CollageDefineSpriteForSheet("_dead_right", 0, 32, 32, 32),
	CollageDefineSpriteForSheet("_dead_up", 0, 64, 32, 32),
	CollageDefineSpriteForSheet("_dead_left", 0, 96, 32, 32),
];
texPage.AddSpriteSheet(_batSprite, _array, "bat", 32, 32, false, false, CollageOrigin.CENTER, CollageOrigin.CENTER);
sprite_delete(_batSprite);