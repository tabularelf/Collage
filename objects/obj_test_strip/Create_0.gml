/*texPage = new Collage();
texPage.addFileStrip("spr_soldier.png");*/
global.__spriteCleanup = [];
function cropSprite(_spr)
{
    var _x = sprite_get_bbox_left(_spr), _y = sprite_get_bbox_top(_spr),
        _x2 = sprite_get_bbox_right(_spr), _y2 = sprite_get_bbox_bottom(_spr);
    var _w = _x2 - _x, _h = _y2 - _y;
	show_debug_message([_x, _y, _x2, _y2]);
    var _surf = surface_create(_w, _h);
    surface_set_target(_surf)
    draw_clear_alpha(c_black, 0)
    draw_sprite(_spr,0,sprite_get_xoffset(_spr)-_x,sprite_get_yoffset(_spr)-_y)
    surface_reset_target()
    var _tmpspr = sprite_create_from_surface(_surf, 0,0, _w, _h, false, false, 0, 0);
    sprite_assign(_spr, _tmpspr)
    surface_free(_surf)
   //sprite_delete(_tmpspr)
   array_push(global.__spriteCleanup, _tmpspr);
   if (alarm[0] <= 0) {
		alarm[0] = 2;   
   }
    return _spr
}

spr = -1;
sprID = sprite_add(working_directory+"spr_soldier.png", 4, false, false, 0, 0);
if (os_browser == browser_not_a_browser) {
	spr = cropSprite(sprID);	
}
/*
spr = cropSprite(_spr);
sprite_delete(_spr);*/

/*surf = surface_create(1024,1024);
surface_set_target(surf);
draw_rectangle_color(32,32, 128, 128, c_red, c_green, c_blue, c_white, false);
surface_reset_target();*/
