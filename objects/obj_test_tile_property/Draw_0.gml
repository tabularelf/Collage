var _info = texPage.GetImageInfo("spr_tiletest");	
var _scale = 4;
draw_surface_ext(texPage.GetTexturePage(0).GetSurface(), -display_mouse_get_x()*_scale*2, -display_mouse_get_y()*_scale*2, _scale, _scale, 0, c_white, 1);

draw_image_stretched(_info, 0, 700, 550, 200, 200);