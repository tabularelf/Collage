//draw_surface(surf, 0, 0);
//if (sprite_exists(spr)) draw_sprite(spr, 0, 0, 0);
//draw_text(8,8, [sprite_exists(spr), spr]);
if (CollageImageExists("spr_soldier")) {
	CollageDrawImage(CollageGetImageInfo("spr_soldier"), current_time / 500, 0, 0);
}
